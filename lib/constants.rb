module RSpecPiccolo
  # Constants
  module Constants
    # RSPec class template
    CLASS_TEMPLATE = <<-EOS
# encoding: utf-8
require "spec_helper"
require "<%=class_path%>"

describe <%=class_name%> do
<%=reportable_prepare%>
<%=methods_template%>
end
    EOS

    REPORTABLE_PREPARE = <<-EOS
  REPORT = "rspec_report"
  DIRS = File.path(__FILE__).gsub(/^.*\\/spec\\//, '').gsub(File.basename(__FILE__), '')
  OUT_DIR = "./#\{REPORT}/#\{DIRS}"
  REPORT_NAME = report_name = File.basename(__FILE__, ".rb")
  REPORT_FILE = "#\{OUT_DIR}#\{REPORT_NAME}.tsv"

  mkspec_report = Proc.new do
    Dir.mkdir(REPORT) unless File.exists?(REPORT)
    FileUtils.mkdir_p(OUT_DIR) unless File.exists?(OUT_DIR)
    File.open(REPORT_FILE, "w") {|f|f.puts "method\\tcase\\ttitle\\tsuccess\\/failure"}
  end.call

  success = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\\tsuccess"}}
  failure = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\\tfailure"}}
    EOS

    # RSPec method template
    METHOD_TEMPLATE = <<-EOS
  context :<%=method_name%> do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",<%=reportable_case%>
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          <%=given_src%>

          # -- when --
          # TODO: implement execute code
          <%=when_src%>

          # -- then --
          # TODO: implement assertion code
          # <%=reportable_case_ret%>expect(actual).to eq(c[:expected])
        ensure
          case_after c<%=reportable_case_after%>
        end
      end

      def case_before(c)
        # implement each case before<%=reportable_case_before%>
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
EOS

    REPORTABLE_CASE = <<-EOS

        success_hook: success,
        failure_hook: failure
    EOS

    REPORTABLE_CASE_BEFORE = <<-EOS

        File.open(REPORT_FILE, "a") {|f|f.print "method_name\\t\#{c[:case_no]}\\t\#{c[:case_title]}"}
    EOS

    REPORTABLE_CASE_AFTER = <<-EOS

          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
    EOS

    REPORTABLE_CASE_RET = 'ret = '

    PRODUCT_CLASS_TEMPLATE = <<-EOS
# encoding: utf-8
<%=require_rb%>
<%=module_start%>
<%=module_indent%>class <%=class_name%>
<%=fields%><%=methods_template%>
<%=module_indent%>end
<%=module_end%>
    EOS
  end
end
