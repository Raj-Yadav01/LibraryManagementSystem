package com.lms.controller;

import java.io.IOException;
import java.util.List;

import com.lms.pojo.Member;
import com.lms.service.MemberService;
import com.lms.serviceImpl.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MemberController")
public class MemberController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final MemberService memberService = new MemberServiceImpl();

    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );

            return;
        }

        String action = request.getParameter("action");

        // Deactivate member
        if ("deactivateMember".equalsIgnoreCase(action)) {

            deactivateMember(request, response);
            return;
        }

        // Delete member
        if ("deleteMember".equalsIgnoreCase(action)) {

            deleteMember(request, response);
            return;
        }

        // View member
        if ("viewMember".equalsIgnoreCase(action)) {

            viewMember(request, response);
            return;
        }

        // Edit member
        if ("editMember".equalsIgnoreCase(action)) {

            editMember(request, response);
            return;
        }
        
        
        // add members
        
        if ("addMember".equalsIgnoreCase(action)) {
            showAddMember(request, response);
            return;
        }

        // Default → Show all members
        showMembers(request, response);
    }


    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );

            return;
        }

        String action = request.getParameter("action");
        // save member...
        if ("saveMember".equalsIgnoreCase(action)) {
            saveMember(request, response);
            return;
        }
        
        
        // Update member
        if ("updateMember".equalsIgnoreCase(action)) {

            updateMember(request, response);
            return;
        }

        // Unknown POST action
        response.sendRedirect(
            request.getContextPath() + "/MemberController"
        );
    }


    // =========================================================
    // SHOW MEMBERS
    // =========================================================

    private void showMembers(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        List<Member> members =
            memberService.getAllMembers();


        // Borrowed books count for every member
        for (Member member : members) {

            int borrowedCount =
                memberService.getBorrowedBookCount(
                    member.getMemberId()
                );

            request.setAttribute(
                "borrowedBooks_" + member.getMemberId(),
                borrowedCount
            );
        }


        // Member list
        request.setAttribute(
            "membersList",
            members
        );


        // Total members
        request.setAttribute(
            "totalMembers",
            memberService.getTotalMembers()
        );


        // Active members
        request.setAttribute(
            "activeMembers",
            memberService.getActiveMembers()
        );


        // Currently borrowing members
        request.setAttribute(
            "borrowingMembers",
            memberService.getBorrowingMembers()
        );


        // Open Members JSP
        request.getRequestDispatcher(
            "/jsp/members.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // DEACTIVATE MEMBER
    // =========================================================

    private void deactivateMember(HttpServletRequest request,
                                  HttpServletResponse response)
            throws IOException {

        String contextPath =
            request.getContextPath();


        try {

            String idParameter =
                request.getParameter("id");


            if (idParameter == null ||
                    idParameter.trim().isEmpty()) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deactivateFailed"
                );

                return;
            }


            int memberId =
                Integer.parseInt(idParameter);


            Member member =
                memberService.getMemberById(memberId);


            // Member not found or already inactive
            if (member == null ||
                    !"Active".equalsIgnoreCase(
                        member.getStatus()
                    )) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deactivateFailed"
                );

                return;
            }


            // Do not deactivate if books are issued/overdue
            int borrowedCount =
                memberService.getBorrowedBookCount(memberId);


            if (borrowedCount > 0) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=hasBorrowings"
                );

                return;
            }


            // Change status
            member.setStatus("Inactive");


            boolean updated =
                memberService.updateMember(member);


            if (updated) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deactivated"
                );

            } else {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deactivateFailed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath +
                "/MemberController?message=deactivateFailed"
            );
        }
    }


    // =========================================================
    // DELETE MEMBER
    // =========================================================

    private void deleteMember(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        String contextPath =
            request.getContextPath();


        try {

            String idParameter =
                request.getParameter("id");


            if (idParameter == null ||
                    idParameter.trim().isEmpty()) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deleteFailed"
                );

                return;
            }


            int memberId =
                Integer.parseInt(idParameter);


            Member member =
                memberService.getMemberById(memberId);


            // Only Inactive members can be deleted
            if (member == null ||
                    !"Inactive".equalsIgnoreCase(
                        member.getStatus()
                    )) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deleteFailed"
                );

                return;
            }


            // Do not delete if books are still issued/overdue
            int borrowedCount =
                memberService.getBorrowedBookCount(memberId);


            if (borrowedCount > 0) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=hasBorrowings"
                );

                return;
            }


            // Delete member
            boolean deleted =
                memberService.deleteMember(memberId);


            if (deleted) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deleted"
                );

            } else {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=deleteFailed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath +
                "/MemberController?message=deleteFailed"
            );
        }
    }


    // =========================================================
    // VIEW MEMBER
    // =========================================================

    private void viewMember(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idParameter =
                request.getParameter("id");


            if (idParameter == null ||
                    idParameter.trim().isEmpty()) {

                response.sendRedirect(
                    request.getContextPath() +
                    "/MemberController?message=memberNotFound"
                );

                return;
            }


            int memberId =
                Integer.parseInt(idParameter);


            Member member =
                memberService.getMemberById(memberId);


            if (member == null) {

                response.sendRedirect(
                    request.getContextPath() +
                    "/MemberController?message=memberNotFound"
                );

                return;
            }


            // Send member to JSP
            request.setAttribute(
                "member",
                member
            );


            // Open View Member page
            request.getRequestDispatcher(
                "/jsp/view-member.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath() +
                "/MemberController?message=memberNotFound"
            );
        }
    }


    // =========================================================
    // EDIT MEMBER
    // =========================================================

    private void editMember(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idParameter =
                request.getParameter("id");


            if (idParameter == null ||
                    idParameter.trim().isEmpty()) {

                response.sendRedirect(
                    request.getContextPath() +
                    "/MemberController?message=memberNotFound"
                );

                return;
            }


            int memberId =
                Integer.parseInt(idParameter);


            Member member =
                memberService.getMemberById(memberId);


            if (member == null) {

                response.sendRedirect(
                    request.getContextPath() +
                    "/MemberController?message=memberNotFound"
                );

                return;
            }


            // Send member data to edit JSP
            request.setAttribute(
                "member",
                member
            );


            // IMPORTANT:
            // Edit ke liye edit-member.jsp open hoga
            request.getRequestDispatcher(
                "/jsp/edit-member.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath() +
                "/MemberController?message=memberNotFound"
            );
        }
    }


    // =========================================================
    // UPDATE MEMBER
    // =========================================================

    private void updateMember(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        String contextPath =
            request.getContextPath();


        try {

            // Member ID
            String memberIdParameter =
                request.getParameter("memberId");


            if (memberIdParameter == null ||
                    memberIdParameter.trim().isEmpty()) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=updateFailed"
                );

                return;
            }


            int memberId =
                Integer.parseInt(memberIdParameter);


            // Form values
            String firstName =
                request.getParameter("firstName");

            String lastName =
                request.getParameter("lastName");

            String email =
                request.getParameter("email");

            String phoneNo =
                request.getParameter("phoneNo");

            String status =
                request.getParameter("status");


            // Basic validation
            if (firstName == null ||
                    firstName.trim().isEmpty() ||

                lastName == null ||
                    lastName.trim().isEmpty() ||

                email == null ||
                    email.trim().isEmpty() ||

                phoneNo == null ||
                    phoneNo.trim().isEmpty() ||

                status == null ||
                    status.trim().isEmpty()) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?action=editMember&id="
                    + memberId
                    + "&message=updateFailed"
                );

                return;
            }


            // Get existing member
            Member member =
                memberService.getMemberById(memberId);


            if (member == null) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=memberNotFound"
                );

                return;
            }


            // Update values
            member.setFirstName(
                firstName.trim()
            );

            member.setLastName(
                lastName.trim()
            );

            member.setEmail(
                email.trim()
            );

            member.setPhoneNo(
                phoneNo.trim()
            );

            member.setStatus(
                status.trim()
            );


            // Update database
            boolean updated =
                memberService.updateMember(member);


            if (updated) {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=updated"
                );

            } else {

                response.sendRedirect(
                    contextPath +
                    "/MemberController?message=updateFailed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath +
                "/MemberController?message=updateFailed"
            );
        }
    }
    private void showAddMember(HttpServletRequest request,
            	HttpServletResponse response)
            throws ServletException, IOException {

    	request.getRequestDispatcher(
    			"/jsp/add-member.jsp"
    	).forward(request, response);
   }


	private void saveMember(HttpServletRequest request,
	         HttpServletResponse response)
	        		 throws IOException {
	
		String contextPath = request.getContextPath();
	
		try {
	
			String firstName =
					request.getParameter("firstName");
	
			String lastName =
					request.getParameter("lastName");
	
			String email =
					request.getParameter("email");
	
			String phoneNo =
					request.getParameter("phoneNo");
	
			String password =
					request.getParameter("password");
	
			String confirmPassword =
					request.getParameter("confirmPassword");
	
	
			// Empty field validation
			if (firstName == null || firstName.trim().isEmpty()
					|| lastName == null || lastName.trim().isEmpty()
					|| email == null || email.trim().isEmpty()
					|| phoneNo == null || phoneNo.trim().isEmpty()
					|| password == null || password.trim().isEmpty()
					|| confirmPassword == null || confirmPassword.trim().isEmpty()) {
	
				response.sendRedirect(
				 contextPath +
				 "/MemberController?action=addMember&message=emptyFields"
				);
	
				return;
			}
	
	
			// Password confirmation
			if (!password.equals(confirmPassword)) {
			
				response.sendRedirect(
						contextPath +
						"/MemberController?action=addMember&message=passwordMismatch"
				);
	
				return;
			}
			
			
			// Create Member object
			Member member = new Member();
			
			member.setFirstName(firstName.trim());
			
			member.setLastName(lastName.trim());
			
			member.setEmail(email.trim());
			
			member.setPhoneNo(phoneNo.trim());
			
			member.setPassword(password);
			
			
			// Save member
			boolean added =
			memberService.addMember(member);
	
	
			if (added) {
			
				response.sendRedirect(
					 contextPath +
					 "/MemberController?message=memberAdded"
				);
			
			} else {
			
				response.sendRedirect(
						contextPath +
						"/MemberController?action=addMember&message=addFailed"
				);
			}
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			response.sendRedirect(
					contextPath +
					"/MemberController?action=addMember&message=addFailed"
			);
		}
	}
    
    
}