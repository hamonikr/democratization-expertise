package com;


import java.io.IOException;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.tomcat.util.descriptor.web.ContextResource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainer;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;


//@MapperScan(value = "com.hamonize.*.service.mapper")
@Configuration
@MapperScan({ "com.hamonize.*.service.mapper", "com.hamonize.restApi.*.service.mapper" })
@EnableConfigurationProperties
public class AppConfig {

	@Value("${spring.datasource.driverClassName}")
	private String driverClassName;
	@Value("${spring.datasource.url}")
	private String url;
	@Value("${spring.datasource.username}")
	private String username;
	@Value("${spring.datasource.password}")
	private String password;

	@Bean
	public TomcatEmbeddedServletContainerFactory tomcatFactory() { // if datasouce defind in tomcat xml configuration
																	// then no need to create this bean
		return new TomcatEmbeddedServletContainerFactory() {

			@Override
			protected TomcatEmbeddedServletContainer getTomcatEmbeddedServletContainer(Tomcat tomcat) {
				tomcat.enableNaming();
				return super.getTomcatEmbeddedServletContainer(tomcat);
			}


			@Override // create JNDI resource
			protected void postProcessContext(Context context) {
				ContextResource resource = new ContextResource();
				resource.setName("jdbc/mariadb");
				resource.setType(DataSource.class.getName());
				resource.setProperty("driverClassName", driverClassName);
				resource.setProperty("url", url);
				resource.setProperty("username", username);
				resource.setProperty("password", password);
				resource.setProperty("factory", "org.apache.tomcat.jdbc.pool.DataSourceFactory");
				resource.setProperty("testWhileIdle", "true");
				resource.setProperty("testOnBorrow", "true");
				resource.setProperty("validationQuery", "SELECT 1");
				resource.setProperty("validationInterval", "5000");
				context.getNamingResources().addResource(resource);
			}

		};
	}


	@Bean(name = "dataSource", destroyMethod = "")
	@Primary
	public DataSource jndiDataSource() throws IllegalArgumentException, NamingException {
		JndiObjectFactoryBean bean = new JndiObjectFactoryBean(); // create JNDI data source
		bean.setJndiName("java:/comp/env/jdbc/mariadb"); // jndiDataSource is name of JNDI data source
		bean.setProxyInterface(DataSource.class);
		bean.setLookupOnStartup(false);
		bean.afterPropertiesSet();
		return (DataSource) bean.getObject();
	}


	@Bean
	@Primary
	public SqlSessionFactory sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource) throws Exception {
		SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
		configureSqlSessionFactory(sessionFactoryBean, dataSource);
		return sessionFactoryBean.getObject();
	}


	@Bean
	@Primary
	public PlatformTransactionManager transactionManager(@Qualifier("dataSource") DataSource mssqlDataSource) {
		DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(mssqlDataSource);
		transactionManager.setGlobalRollbackOnParticipationFailure(false);
		// transactionManager.setRollbackOnCommitFailure(true);
		return transactionManager;
	}


	public void configureSqlSessionFactory(SqlSessionFactoryBean sessionFactoryBean, DataSource dataSource)
			throws IOException {
		PathMatchingResourcePatternResolver pathResolver = new PathMatchingResourcePatternResolver();
		sessionFactoryBean.setDataSource(dataSource);
		sessionFactoryBean.setMapperLocations(pathResolver.getResources("classpath:publicMapper/*.xml"));
	}

}