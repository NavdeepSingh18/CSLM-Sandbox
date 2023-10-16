page 50228 "Promotion Stud Hdr-CS"
{
    // version V.001-CS

    // No   Emp.ID       Date          Trigger                         Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.  CSPL-00174   05-01-19    OnOpenPage()                     Code added for boolian field true.
    // 02.  CSPL-00174   05-01-19    OnAfterGetRecord()               Code added for editable or non-editable field.
    // 03.  CSPL-00174   05-01-19    OnNewRecord()                    Code added for boolian field true.
    // 04.  CSPL-00174   05-01-19    No. - OnAssistEdit()             Code added for generate no Series .
    // 05.  CSPL-00174   05-01-19    Course - OnValidate()            Code added for editable or non-editable field.
    // 06.  CSPL-00174   05-01-19    Type Of Course - OnValidate()    Code added for editable or non-editable field.
    // 07.  CSPL-00174   05-01-19    Get Students - OnAction()        Code added to get the students.
    // 08.  CSPL-00174   05-01-19    Promote - OnAction()             Code added to Promote the stduents.
    // 09.  CSPL-00174   05-01-19    Generate Course Fee - OnAction() Code added to generate course Fee .
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Promotion Student Header';
    PageType = Card;
    SourceTable = "Promotion Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = EditPage;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //Code added for generate no Series :::CSPL-00174::050119: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for generate no Series ::CSPL-00174::050119: End
                    end;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::050119: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::050119: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Next Academic Year"; Rec."Next Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Term"; Rec."Term")
                {
                    ApplicationArea = All;
                }
                field("Next Term"; Rec."Next Term")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::050119: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::050119: End
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    Editable = EditableBTNSEM;
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNYR;
                }
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Section; Rec.Section)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            part(Promotion; "Promotion Stud SubPage-CS")
            {
                ApplicationArea = All;
                Editable = EditPage;
                SubPageLink = "Document No." = FIELD("No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Fu&nction';
                action("Get Students")
                {
                    Caption = 'Get &Students';
                    Image = Employee;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Mandatory field::CSPL-00174::050119: Start
                        Rec.TESTFIELD(Course);
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN
                            Rec.TESTFIELD(Semester)
                        ELSE
                            Rec.TESTFIELD(Year);
                        Rec.TESTFIELD("Academic Year");
                        Rec.TESTFIELD("Global Dimension 1 Code");
                        ExaminationManagement.GetStudentsPromotionLine(Rec);
                        //AttendanceActionCS.GetStudentsPromotionDetail(Rec);
                        //Code added for Mandatory field::CSPL-00174::050119: End
                    end;
                }
                action(Promote)
                {
                    Caption = '&Promote';
                    Image = TransferFunds;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to Promote the stduents::CSPL-00174::050119: Start

                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            ExaminationManagement.AcademicsPromotion(Rec);
                            /*
                            PromotionHeaderCS.Reset();
                            PromotionHeaderCS.SETFILTER("No.", "No.");
                            StudentPromotionProcess.USEREQUESTPAGE(FALSE);
                            StudentPromotionProcess.SETTABLEVIEW(PromotionHeaderCS);
                            StudentPromotionProcess.RUN();
                            Promoted := TRUE;

                            PromotionLineCS.Reset();
                            PromotionLineCS.SETRANGE("Document No.", "No.");
                            PromotionLineCS.SETRANGE("Student Promoted", TRUE);
                            IF PromotionLineCS.FINDSET() THEN
                                REPEAT
                                    InformationOfStudentCS.StudentSubjectUpdateCS(PromotionLineCS."Student No.");
                                UNTIL PromotionLineCS.NEXT() = 0;
                            */
                        END;

                        StudentPromotionLineCS.Reset();
                        StudentPromotionLineCS.SETRANGE("Document No.", Rec."No.");
                        StudentPromotionLineCS.SETRANGE("Student Promoted", FALSE);
                        IF StudentPromotionLineCS.FINDFIRST() THEN
                            EditPage := TRUE
                        ELSE
                            EditPage := FALSE;
                        CurrPage.Update();
                        //Code added to Promote the stduents::CSPL-00174::CSPL-00174::050119: End
                    end;
                }
                action("Generate Course Fee")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to Generate course fee::CSPL-00174::CSPL-00174::050119: Start
                        StudentPromotionLineCS.Reset();
                        StudentPromotionLineCS.SETRANGE("Document No.", Rec."No.");
                        StudentPromotionLineCS.SETRANGE("Student Promoted", TRUE);
                        StudentPromotionLineCS.SETRANGE("Fee Generated", FALSE);
                        IF StudentPromotionLineCS.FINDSET() THEN
                            REPEAT
                                InformationOfStudentCS.FeeCreationOnStudentPromotionCS(StudentPromotionLineCS."Student No.", StudentPromotionLineCS."Fee Generated");
                                StudentPromotionLineCS.Modify();
                            UNTIL StudentPromotionLineCS.NEXT() = 0;
                        //Code added to Generate course fee::CSPL-00174::CSPL-00174::050119:End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for editable or non-editable field:::CSPL-00174::050119: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for editable or non-editable field:::CSPL-00174::050119: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for boolian field true:::CSPL-00174::050119:Start
        EditPage := TRUE;
        //Code added for boolian field true:::CSPL-00174::050119: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for boolian field true::CSPL-00174::050119: Start
        EditableBTNSEM := TRUE;
        EditableBTNYR := TRUE;
        EditPage := TRUE;
        //Code added for boolian field true:::CSPL-00174::050119: End
    end;

    var
        //PromotionLineCS: Record "Promotion Line-CS";
        StudentPromotionLineCS: Record "Promotion Line-CS";
        //PromotionHeaderCS: Record "Promotion Header-CS";
        //StudentPromotionProcess: Report "Student Promotion Process";
        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
        //AttendanceActionCS: Codeunit "Attendance Action-CS";
        ExaminationManagement: Codeunit "Examination Management";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
        Text001Lbl: Label 'Do You Want To  Promote Students ?';
        EditPage: Boolean;

}

