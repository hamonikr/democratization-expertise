package com.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.de.sample.SampleRepository;
@DataJpaTest
public class SampleRepositoryTest {
	@Autowired private SampleRepository sampleRepository;
}
