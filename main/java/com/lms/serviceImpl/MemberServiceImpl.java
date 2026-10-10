package com.lms.serviceImpl;

import java.util.List;

import com.lms.dao.MemberDao;
import com.lms.daoImpl.MemberDaoImpl;
import com.lms.pojo.Member;
import com.lms.service.MemberService;

public class MemberServiceImpl implements MemberService {

    private final MemberDao memberDao = new MemberDaoImpl();

    @Override
    public List<Member> getAllMembers() {
        return memberDao.getAllMembers();
    }

    @Override
    public Member getMemberById(int memberId) {
        return memberDao.getMemberById(memberId);
    }

    @Override
    public boolean addMember(Member member) {
        return memberDao.addMember(member);
    }

    @Override
    public boolean updateMember(Member member) {
        return memberDao.updateMember(member);
    }

    @Override
    public boolean deleteMember(int memberId) {
        return memberDao.deleteMember(memberId);
    }

    @Override
    public int getTotalMembers() {
        return memberDao.getTotalMembers();
    }

    @Override
    public int getActiveMembers() {
        return memberDao.getActiveMembers();
    }

    @Override
    public int getBorrowingMembers() {
        return memberDao.getBorrowingMembers();
    }
    
    @Override
    public int getBorrowedBookCount(int memberId) {
        return memberDao.getBorrowedBookCount(memberId);
    }
}