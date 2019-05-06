settings {
    logfile = "/var/log/lsyncd/lsyncd.log",
    statusFile = "/var/log/lsyncd/lsyncd.status",
    insist = true,
    statusInterval = 1,
}
    
sync {
    default.rsyncssh,
    source = "/opt/media",
    host = "thomas@70.112.163.27",
    targetdir = "/opt/plexmedia/ThomasSync",
    delete = "running",
    rsync = {
        compress = false,
    },
    ssh = {
        port = 9876,
    },
}