class aliases::config {

	file { "/etc/aliases" :
		ensure => present,
		mode   => 600,
		owner  => "root",
		group  => "root"
	}

	file { "/etc/aliases.db" :
		ensure => present,
		mode   => 600,
		owner  => "root",
		group  => "root",
		notify    => Exec["newaliases"]
	}

	mailalias { "root":
		ensure    => present,
		recipient => $aliases::root,
		notify    => Exec["newaliases"]
	}

	mailalias { "postmaster":
		ensure    => present,
		recipient => 'root',
		notify    => Exec["newaliases"]
	}

	mailalias { "amavis":
		ensure    => present,
		recipient => 'root',
		notify    => Exec["newaliases"]
	}

	# Rebuild the database, but only when the file changes
	exec { newaliases:
		path        => ["/usr/bin", "/usr/sbin"],
		refreshonly => true,
	}

	# Mailalias <<||>> {  } # werkt alleen met activerecord/rails op de master
}
