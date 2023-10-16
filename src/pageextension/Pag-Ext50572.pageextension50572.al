pageextension 50572 "pageextension50572" extends "Requests to Approve"
{
    // version NAVW19.00.00.45778-CS

    // Sr.No.    Emp. ID       Date          Trigger               Remarks
    // 1         CSPL-00136    02-05-2019    Approve - OnAction      Code Add For  Update Credit Grade Points On Student Subject College.
    // 2         CSPL-00136    02-05-2019    Reject - OnAction      Code Add For  Update Credit Grade Points On Student Subject College.s
    actions
    {


        //Unsupported feature: Code Modification on "Approve(Action 19).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ApprovalEntry);
        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ApprovalEntry);
        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
        //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-000136::19022019: Start
        EventsOfExaminationCS.CSUpdateCreditGradePointsOnStudentSubjectCollege("Document No.",'RELEASED');
        //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-000136::19022019: End
        */
        //end;


        //Unsupported feature: Code Modification on "Reject(Action 2).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ApprovalEntry);
        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ApprovalEntry);
        ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
        //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-000136::19022019: Start
        EventsOfExaminationCS.CSUpdateCreditGradePointsOnStudentSubjectCollege("Document No.",'REOPEN');
        //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-000136::19022019: End
        */
        //end;
    }

    var

}

