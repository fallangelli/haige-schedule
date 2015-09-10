package com.haige.schedule.service;

import com.haige.schedule.entity.ClassSchedule;
import com.haige.schedule.entity.Member;
import com.haige.schedule.repository.ClassScheduleDao;
import com.haige.schedule.repository.MemberDao;
import com.haige.schedule.vo.ScheduleDateVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

@Service
public class ClassScheduleService {

    @Autowired
    private ClassScheduleDao classScheduleDao;

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private RBACService rbacService;

    public Page<ClassSchedule> getAllClassSchedule(Pageable page) {
        return classScheduleDao.findAll(page);
    }


    public Page<ClassSchedule> queryClassSchedules(String classBasename, Long queryTeacherId, Date queryScheduleDate, Pageable page) {
        List<Object> params = new ArrayList<>();
        List<String> items = new ArrayList<String>();

        String sql = "select * from class_schedule cs \n" +
                "left join classes c on cs.classId = c.id where 1=1 ";
        if (!StringUtils.isEmpty(classBasename)) {
            sql += " and ( c.name like :classBasename or c.type like :classBasename)";
            items.add("classBasename");
            params.add("%" + classBasename + "%");
        }
        if (queryTeacherId != null) {
            sql += " and cs.teacherId = :teacherId ";
            items.add("teacherId");
            params.add(queryTeacherId);
        }

        if (queryScheduleDate != null) {
            sql += " and cs.scheduleDate = :scheduleDate ";
            items.add("scheduleDate");
            params.add(queryScheduleDate);
        }
        String[] strArr = new String[items.size()];
        return classScheduleDao.queryNativeSqlPageEntity(sql, items.toArray(strArr), params.toArray(), page);
    }


    public ClassSchedule getClassScheduleById(long id) {
        return classScheduleDao.findOne(id);
    }

    public void saveClassSchedule(ClassSchedule classSchedule) {
        classScheduleDao.save(classSchedule);
    }

    public void finishClassSchedule(Long evScheduleid, String evaluation) {
        classScheduleDao.recordHisSchedule(evScheduleid, evaluation);
        classScheduleDao.delete(evScheduleid);
    }


    public void deleteClassSchedule(Long id) {
        classScheduleDao.delete(id);
    }

    public void addCSMembers(Long id, List<Long> memberIds) {
        ClassSchedule cs = classScheduleDao.findOne(id);
        for (Long memberId : memberIds) {
            Member member = memberDao.findOne(memberId);
            cs.getMembers().add(member);
            classScheduleDao.save(cs);
        }
    }

    public void deleteCSMember(Long id, Long memberId) {
        ClassSchedule cs = classScheduleDao.findOne(id);
        Set<Member> members = cs.getMembers();
        for (Member member : members) {
            if (member.getId().equals(memberId)) {
                members.remove(member);
                classScheduleDao.save(cs);
                break;
            }
        }

    }

    public List<ScheduleDateVO> getScheduleDataByData(java.util.Date beginDate, java.util.Date endDate) {
        List<ClassSchedule> scheduleList = classScheduleDao.findScheduleByDateFilter(beginDate, endDate);
        List<ScheduleDateVO> retList = new ArrayList<>();
        for (ClassSchedule cs : scheduleList) {
            String title = cs.getClassBase().getName() + " " + cs.getClassBase().getType() + " " + cs.getTeacher().getRealName();
            Calendar calStart = Calendar.getInstance();
            calStart.setTime(cs.getScheduleDate());
            Calendar calTmp = Calendar.getInstance();
            calTmp.setTime(cs.getStartTime());
            calStart.set(Calendar.HOUR, calTmp.get(Calendar.HOUR));
            calStart.set(Calendar.MINUTE, calTmp.get(Calendar.MINUTE));
            calStart.set(Calendar.SECOND, calTmp.get(Calendar.SECOND));
            Calendar calEnd = Calendar.getInstance();
            calEnd.setTime(cs.getScheduleDate());
            calTmp = Calendar.getInstance();
            calTmp.setTime(cs.getEndTime());
            calEnd.set(Calendar.HOUR, calTmp.get(Calendar.HOUR));
            calEnd.set(Calendar.MINUTE, calTmp.get(Calendar.MINUTE));
            calEnd.set(Calendar.SECOND, calTmp.get(Calendar.SECOND));
            ScheduleDateVO vo = new ScheduleDateVO(cs.getId(), title, calStart.getTime(), calEnd.getTime());
            retList.add(vo);
        }
        return retList;
    }

    public Long getCSCount() {
        return classScheduleDao.count();
    }
}
