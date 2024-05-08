package model;
import java.util.*;

public interface StuDAO {

	//학생목록
	public ArrayList<StuVO> list (QueryVO vo);
	//검색수
	public int total(QueryVO vo);
	//새로운학번 구하기
	public String getCode();
	//학생정보 pk
	public StuVO read (String scode);
	//학생입력
	public void insert(StuVO vo);
	//학생수정
	public void update(StuVO vo);
	//학생삭제 pk
	public void delete(String scode);
}
