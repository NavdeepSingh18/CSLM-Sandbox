page 50403 "Applicants Rejec. Stage1-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   15/02/2019      Admit Student - OnAction()                Code added for admit student.
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")//GMCSCOM
    WHERE(Rejected = FILTER(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {

            systempart(Note; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Prequalification Subjects")
            {
                ApplicationArea = All;
                Caption = 'Prequalification Subjects';
                Image = Allocate;
                RunObject = Page 50264;
                RunPageLink = "Document No." = FIELD("No."),
                              "Faculty 1 Name" = FIELD("Course Code");
            }
            action("Admit Student")
            {
                Caption = 'Admit Student';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for admit student::CSPL-00059::15022019: Start
                    ApplPrequalificationCS.Reset();
                    ApplPrequalificationCS.SETRANGE("No.", Rec."No.");
                    APP_TotalCS := 0;
                    StCount_Total := 0;
                    IF ApplPrequalificationCS.FINDSET() THEN
                        REPEAT
                            APP_TotalCS := APP_TotalCS + ApplPrequalificationCS."Percentage of Mark";
                            StCount_Total += 1;
                            REQ_Total := (APP_TotalCS / StCount_Total);
                        UNTIL
ApplPrequalificationCS.NEXT() = 0;

                    CourseEligibleSummaryCS.Reset();
                    CourseEligibleSummaryCS.SETRANGE("Course Code", Rec."Course Code");
                    APPCourse := 0;
                    Count_Course := 0;
                    IF CourseEligibleSummaryCS.FINDSET() THEN
                        REPEAT
                            APPCourse := APPCourse + CourseEligibleSummaryCS.Percentage;
                            Count_Course += 1;
                            ReqCourse := (APPCourse / Count_Course);
                        UNTIL
CourseEligibleSummaryCS.NEXT() = 0;

                    ApplPrequalificationCS.SETRANGE("Course Code", CourseEligibleSummaryCS."Course Code");
                    IF REQ_Total > ReqCourse THEN BEGIN
                        IF Rec.Spot OR Rec."Is Recommended" THEN BEGIN
                            IF Rec."Check Age Limt" AND (Rec.Age <> 0) THEN BEGIN
                                IF AdmissionStage1CS.LimitAgeCheckCS(Rec."Course Code", Rec.Age) THEN BEGIN
                                    FeeDiscountHeadCS.Reset();
                                    FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                    IF FeeDiscountHeadCS.FindFirst() THEN
                                        Rec."Discount Applicable" := TRUE;
                                    AdmissionStage1CS.StudentNoAllotCS(Rec."No.");
                                END
                                ELSE
                                    ERROR(Text000Lbl);
                            END ELSE BEGIN
                                FeeDiscountHeadCS.Reset();
                                FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                IF FeeDiscountHeadCS.FindFirst() THEN
                                    Rec."Discount Applicable" := TRUE;
                                AdmissionStage1CS.StudentNoAllotCS(Rec."No.");
                            END;
                        END ELSE
                            ERROR(Text001Lbl);
                    END
                    ELSE BEGIN
                        Rec."Rejected Reason" := 'Not Eligible for Prequalification Marks';
                        Rec.Rejected := TRUE;
                        MESSAGE('Not Eligibile');
                    END;


                    IF Rec."Discount Code" <> '' THEN
                        Rec.GenerateCreditMemo();

                    //Code added for admit student::CSPL-00059::15022019: End
                end;
            }
        }
    }

    var

        ApplPrequalificationCS: Record "Appl Prequalification-CS";
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
        AdmissionStage1CS: Codeunit "Admission Stage1-CS";
        APP_TotalCS: Decimal;
        StCount_Total: Decimal;
        REQ_Total: Decimal;
        APPCourse: Decimal;
        Count_Course: Decimal;
        ReqCourse: Decimal;

        Text000Lbl: Label 'Age limt exceeds';
        Text001Lbl: Label 'Please mark either Spot or Is Recommended';
}