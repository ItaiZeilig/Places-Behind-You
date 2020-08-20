package acs.dal;
import java.util.List;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import acs.data.ElementEntity;
import acs.data.entityProperties.LocationEntity;

@Repository
public interface ElementDao extends MongoRepository<ElementEntity,String>{

	public List<ElementEntity> findAllByName(
			@Param("name") String name,
			Pageable pageable); 
	
	public List<ElementEntity> findAllByNameAndActive(
			@Param("name") String name,
			@Param("active") Boolean active,
			Pageable pageable);

	public List<ElementEntity> findAllByType(
			@Param("type") String type,
			Pageable pageable); 

	public List<ElementEntity> findAllByTypeAndActive(
			@Param("type") String type,
			@Param("active") Boolean active,
			Pageable pageable);

	public List<ElementEntity> findAllByElementId(
			@Param("elementId") String elementId,
			Pageable pageable); 
	
	public List<ElementEntity> findOneByElementIdAndActive(
			@Param("elementId") String elementId,
			@Param("active") Boolean active,
			Pageable pageable);


	public List<ElementEntity> findAllByParent_elementId(
			@Param("ParentElementId") String ParentElementId,
			Pageable pageable);
	
	public List<ElementEntity> findAllByParent_elementIdAndActive(
			@Param("ParentElementId") String ParentElementId,
			@Param("active") Boolean active,
			Pageable pageable);
	
	
	public List<ElementEntity> findAllByChildrens_elementId(
			@Param("ChildrensElementId") String ChildrensElementId,
			Pageable pageable);
	
	public List<ElementEntity> findAllByChildrens_elementIdAndActive(
			@Param("ChildrensElementId") String ChildrensElementId,
			@Param("active") Boolean active,
			Pageable pageable);

	public List<ElementEntity> findByLocation(
			@Param("location") LocationEntity location,
			Pageable pageable);

	public List<ElementEntity> findByLocationAndActive(
			@Param("location") LocationEntity location,
			@Param("active") Boolean active,
			Pageable pageable);

	public List<ElementEntity> findAllByActive(
			@Param("active") Boolean active,
			Pageable pageable);
}
