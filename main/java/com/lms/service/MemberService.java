package com.lms.service;

import java.util.List;
import com.lms.pojo.Member;

public interface MemberService {

    List<Member> getAllMembers();

    Member getMemberById(int memberId);

    boolean addMember(Member member);

    boolean updateMember(Member member);

    boolean deleteMember(int memberId);

    int getTotalMembers();

    int getActiveMembers();

    int getBorrowingMembers();
    
    int getBorrowedBookCount(int memberId);
}