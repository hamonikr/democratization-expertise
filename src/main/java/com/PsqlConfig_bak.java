package com;

//@Configuration
//@MapperScan("com.de.*.mapper")
//@EnableTransactionManagement
//public class PsqlConfig_bak {
//	
//	// Private fields
//	  @Autowired
//	  private Environment env;
//	 
//	  @Autowired
//	  private DataSource dataSource;
//	 
//	  @Bean
//	  public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
//	    LocalContainerEntityManagerFactoryBean entityManagerFactory = new LocalContainerEntityManagerFactoryBean();
//	 
//	    entityManagerFactory.setDataSource(dataSource);
//	    entityManagerFactory.setPackagesToScan(new String[] { "com.de.*.mapper" }); // Classpath scanning of @Component, @Service, etc annotated class
//	    entityManagerFactory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
//	 
//	    Properties additionalProperties = new Properties(); // Hibernate properties
//	    additionalProperties.put("hibernate.dialect", env.getProperty("spring.jpa.properties.hibernate.dialect"));
//	    additionalProperties.put("hibernate.show_sql", env.getProperty("spring.jpa.show-sql"));
//	    additionalProperties.put("hibernate.hbm2ddl.auto", env.getProperty("spring.jpa.hibernate.ddl-auto"));
//	    entityManagerFactory.setJpaProperties(additionalProperties);
//	 
//	    return entityManagerFactory;
//	  }
//	 
//	  @Bean
//	  public JpaTransactionManager transactionManager(EntityManagerFactory emf) {
//	    JpaTransactionManager transactionManager = new JpaTransactionManager();
//	    transactionManager.setEntityManagerFactory(emf);
//	    return transactionManager;
//	  }
//	 
//	  @Bean
//	  public PersistenceExceptionTranslationPostProcessor exceptionTranslation() {
//	    return new PersistenceExceptionTranslationPostProcessor();
//	  }
//	 
//	  @Bean
//	  public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//	    final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
//	    sessionFactory.setDataSource(dataSource);
//	    PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
//	    sessionFactory.setMapperLocations(resolver.getResources("classpath:publicMapper/*.xml"));
//	    Properties property = new Properties();  // DB에서 사용할 값들 설정
//	    property.setProperty("key", "val");
//	    sessionFactory.setConfigurationProperties(property);
//	    return sessionFactory.getObject();
//	  }
//	 
//	  @Bean
//	  public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
//	    final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
//	    return sqlSessionTemplate;
//	  }

//}
