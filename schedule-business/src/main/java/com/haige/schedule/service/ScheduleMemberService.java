package com.haige.schedule.service;

import com.haige.schedule.entity.ScheduleMember;
import com.haige.schedule.repository.ScheduleMemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lcheng on 2014/5/11.
 */
@Service
public class ScheduleMemberService {

    @Autowired
    private ScheduleMemberDao smDao;

    public List<ScheduleMember> getAllScheduleMembers() {
        return smDao.findAll();
    }

    public ScheduleMember getScheduleMember(Long id) {
        return smDao.findOne(id);
    }

    public ScheduleMember getScheduleMember(Long scheduleId, Long memberId) {
        return smDao.findByScheduleIdAndMemberId(scheduleId, memberId);
    }


    public void save(ScheduleMember classBase) {
        smDao.save(classBase);
    }


    public void updateComment(long id, String comment) {
        ScheduleMember sm = getScheduleMember(id);
        sm.setComment(comment);
        smDao.save(sm);
    }

    public void delete(Long id) {
        smDao.delete(id);
    }
}
