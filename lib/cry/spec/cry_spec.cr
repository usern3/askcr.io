require "./spec_helper"

describe Cry do
  it "accepts a template file when passing in code" do
    Cry::CodeRunner.new(
      code: %(puts "Hello World!"),
      editor: "tail",
      template: "spec/support/template.cr",
    ).run

    newest_result.should eq <<-RESULT
    From template
    Hello World!
    nil

    RESULT
    newest_code.should eq <<-CODE
    puts "From template"
    puts (puts "Hello World!").inspect
    CODE
  end

  it "accepts a template file when using just the editor" do
    Cry::CodeRunner.new(
      code: "",
      editor: "tail",
      template: "spec/support/template.cr",
    ).run

    newest_result.should eq "From template\n"
    newest_code.should eq %(puts "From template"\n)
  end

  it "logs to the configured location" do
    change_logs_directory "./tmp/console" do
      original_log_count = `ls tmp/console/*_console_result.log`.strip.split(/\s/).size

      Cry::CodeRunner.new(
        code: %(puts "Hello World!"),
        editor: "echo",
      ).run

      logs = `ls tmp/console/*_console_result.log`.strip.split(/\s/).sort
      logs.size.should eq(original_log_count + 1)
      File.read(logs.last).should contain "Hello World!"
    end
  end
end

private def change_logs_directory(directory)
  original_logs_directory = Cry::Logs.directory
  begin
    Cry::Logs.directory = directory
    yield
  ensure
    Cry::Logs.directory = original_logs_directory
  end
end

private def newest_code
  Cry::Logs.new.newest.code
end

private def newest_result
  Cry::Logs.new.newest.results
end
