dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
			pooled = true
			dbCreate = "update"
			url = "jdbc:mysql://localhost/am"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "harr\$0909"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
			url = "jdbc:mysql://localhost/am"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "harr\$0909"        
		}
    }
    production {
        dataSource {
            dbCreate = "update"
			url = "jdbc:mysql://localhost/am"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "harr\$0909" 
		}
    }
}
