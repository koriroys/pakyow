Pakyow::App.define do
  configure(:test) do
    presenter.view_stores[:mailer] = "test/views"
  end
  
  # This keeps the app from actually being run.
  # def self.detect_handler
  #   TestHandler
  # end
end