package com.de.sample;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.de.sample.mapper.SampleMapper;


@Service
@Transactional
public class SampleService {
	
	@Autowired
	SampleRepository sr;
	
	@Autowired
	SampleMapper sm;
	
	public Page<Sample> findAll(Pageable pageable) throws Exception{
		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
        pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerDate"));
		Page<Sample> list = sr.findAllByDeleteAt(0,pageable);

		return list;
	}
	
	public Optional<Sample> findById(int seq) throws Exception{
		return sr.findById(seq);
	}
	
	public Sample save(Sample vo) throws Exception{
		
		return sr.save(vo);
	}
	
	public void updateById(Sample vo) throws Exception{
		Optional<Sample> e = sr.findById(vo.getSeq());
		if (e.isPresent()) {
			e.get().setContents(vo.getContents());
			e.get().setTitle(vo.getTitle());
			sr.save(vo);
		}

  }
	
	public List<Sample> list(Pageable pageable) throws Exception{
		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
        pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerDate"));
		List<Sample> list = sm.list();

		return list;
	}

}
