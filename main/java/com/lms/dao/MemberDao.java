package com.lms.dao;

import java.util.List;
import com.lms.pojo.Member;

public interface MemberDao {

    // Get all library members
    List<Member> getAllMembers();
    
    int getBorrowedBookCount(int memberId);

    // Get member by ID
    Member getMemberById(int memberId);

    // Add a new member
    boolean addMember(Member member);

    // Update member details
    boolean updateMember(Member member);

    // Delete or deactivate member
    boolean deleteMember(int memberId);

    // Total members count
    int getTotalMembers();

    // Active members count
    int getActiveMembers();

    // Members currently borrowing books
    int getBorrowingMembers();
}