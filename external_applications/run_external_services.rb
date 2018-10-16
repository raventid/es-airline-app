CONTROL_FILE = "./external_services_pids"
APPLICATIONS = [charters, wolfgang, insurance, notifications]

commands do |c|
  c.register "start" do
    # run applications with start
    # write their pids in files
    APPLICATIONS.each do |app|
      pid = app.start

      app.name pid if pid
    end
  end

  c.register "stop" do
    # read pid for files
    # stop all of the services
  end
end
