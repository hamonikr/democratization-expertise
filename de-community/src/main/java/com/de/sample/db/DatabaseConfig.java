package com.de.sample.db;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.de.sample.GlobalPropertySource;
 


@Configuration
@MapperScan(basePackages="com.de.sample")
@EnableTransactionManagement
public class DatabaseConfig {
 
    @Autowired
    GlobalPropertySource globalPropertySource;
    
    @Bean
    @Primary
    public DataSource customDataSource() {
        return DataSourceBuilder
            .create()
            .url(globalPropertySource.getUrl())
            .driverClassName(globalPropertySource.getDriverClassName())
            .username(globalPropertySource.getUsername())
            .password(globalPropertySource.getPassword())
            .build();
    }
   
    
    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
      final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
      return sqlSessionTemplate;
    }
 
 
}

