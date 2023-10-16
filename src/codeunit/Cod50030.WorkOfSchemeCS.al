codeunit 50030 "Work Of Scheme -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     ApplyStaffPlan()-Function        Code added for apply staff plan.
    // 02    CSPL-00059   18/02/2019     ApproveStaffPlan()-Function      Code added for approved staff plan .
    // 03    CSPL-00059   18/02/2019     RejectStaffPlan()-Function       Code added for reject staff plan.


    trigger OnRun()
    begin
    end;

    var
        CoursePlanHeadFacultyCS: Record "Course Plan Head Faculty-CS";
        Text001Lbl: Label 'Already the Plan Has been Applied';
        Text002Lbl: Label 'Already the Plan Has been Appoved';
        Text003Lbl: Label 'Already the Plan Has been Rejected';
        Text004Lbl: Label 'Do you want to send this for approval ?';
        Text005Lbl: Label 'The Plan Has not been Applied';
        Text006Lbl: Label 'Already the Plan Has been Appoved';
        Text007Lbl: Label 'Do you want approve this plan ?';
        Text008Lbl: Label 'The Plan Has not been Applied';
        Text009Lbl: Label 'Already the Plan Has been Appoved';
        Text010Lbl: Label 'Already the Plan Has been Rejected';
        Text011Lbl: Label 'Do you want reject this plan ?';
        Text012Lbl: Label 'Please give the comments for the rejection';

    procedure ApplyStaffPlan(DocNo: Code[20])
    begin
        //Code added for apply staff plan::CSPL-00059::18022019: Start
        IF CoursePlanHeadFacultyCS.GET(DocNo) THEN BEGIN
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Applied THEN
                ERROR(Text001Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Approved THEN
                ERROR(Text002Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Rejected THEN
                ERROR(Text003Lbl);
            IF CONFIRM(Text004Lbl, TRUE) THEN BEGIN
                CoursePlanHeadFacultyCS."Plan Status" := CoursePlanHeadFacultyCS."Plan Status"::Applied;
                CoursePlanHeadFacultyCS.Modify();
            END;
        END;
        //Code added for apply staff plan::CSPL-00059::18022019: End
    end;

    procedure ApproveStaffPlan(DocNo: Code[20])
    begin
        //Code added for approved staff plan::CSPL-00059::18022019: Start
        IF CoursePlanHeadFacultyCS.GET(DocNo) THEN BEGIN
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::" " THEN
                ERROR(Text005Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Approved THEN
                ERROR(Text006Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Applied THEN
                IF CONFIRM(Text007Lbl, TRUE) THEN BEGIN
                    CoursePlanHeadFacultyCS."Plan Status" := CoursePlanHeadFacultyCS."Plan Status"::Approved;
                    CoursePlanHeadFacultyCS.Modify();
                END;
        END;
        //Code added for approved staff plan::CSPL-00059::18022019: End
    end;

    procedure RejectStaffPlan(DocNo: Code[20])
    begin
        //Code added for reject staff plan::CSPL-00059::18022019: Start
        IF CoursePlanHeadFacultyCS.GET(DocNo) THEN BEGIN
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::" " THEN
                ERROR(Text008Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Approved THEN
                ERROR(Text009Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Rejected THEN
                ERROR(Text010Lbl);
            IF CoursePlanHeadFacultyCS."Plan Status" = CoursePlanHeadFacultyCS."Plan Status"::Applied THEN
                IF CONFIRM(Text011Lbl, TRUE) THEN BEGIN
                    IF CoursePlanHeadFacultyCS.Comments = '' THEN
                        ERROR(Text012Lbl);
                    CoursePlanHeadFacultyCS."Plan Status" := CoursePlanHeadFacultyCS."Plan Status"::Rejected;
                    CoursePlanHeadFacultyCS.Modify();
                END;
        END;
        //Code added for reject staff plan::CSPL-00059::18022019: Start
    end;
}

