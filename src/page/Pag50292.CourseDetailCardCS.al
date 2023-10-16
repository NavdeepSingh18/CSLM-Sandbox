page 50292 "Course Detail Card-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                               Remarks
    // 1         CSPL-00092    23-05-2019    OnOpenPage                            Flag true
    // 2         CSPL-00092    23-05-2019    OnAfterGetRecord                      Condition based Flag true or false
    // 3         CSPL-00092    23-05-2019    Type Of Course - OnValidate           Condition based Flag true or false
    // 4         CSPL-00092    23-05-2019    Course Optional Subjects - OnAction   Page Run
    // 5         CSPL-00092    23-05-2019    <Action1102155059> - OnAction         Page Run
    // 6         CSPL-00092    23-05-2019    <Action1000000010> - OnAction         Page Run

    Caption = 'Course Detail Card';
    PageType = Card;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Course Master-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Course Category"; Rec."Course Category")
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field("Additional Subject Grade"; Rec."Additional Subject Grade")
                {
                    ApplicationArea = all;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ToolTip = 'Type Of Course';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for Condition based Flag true or false::CSPL-00092::23-05-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END;
                        IF Rec."Type Of Course" <> Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for Condition based Flag true or false::CSPL-00092::23-05-2019: Start
                    end;

                }
                field("Degree Code"; Rec."Degree Code")
                {
                    ApplicationArea = all;
                }
                // field("Category Code"; Rec."Category Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Category Description"; Rec."Category Description")
                // {
                //     ApplicationArea = All;
                // }


                field("Promotion Criteria"; Rec."Promotion Criteria")
                {
                    ToolTip = 'Promotion Criteria';
                    ApplicationArea = All;
                }
                field("Core Rotation Weeks"; Rec."Core Rotation Weeks")
                {
                    ApplicationArea = All;
                }
                field("Elective Rotation Weeks"; Rec."Elective Rotation Weeks")
                {
                    ApplicationArea = All;
                }
                field("Min. Passing Credit"; Rec."Min. Passing Credit")
                {
                    ToolTip = 'Min. Passing Credit';
                    ApplicationArea = All;
                }
                field("Final Semester Code"; Rec."Final Semester Code")
                {
                    ToolTip = 'Final Semester Code';
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field("Final Years Course"; Rec."Final Years Course")
                {
                    ToolTip = 'Final Years Course';
                    Editable = EditableBTNYR;
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ToolTip = 'Graduation';
                    ApplicationArea = All;
                }
                field("Duration of Years"; Rec."Duration of Years")
                {
                    ToolTip = 'Duration of Years';
                    Caption = 'Number of Year';
                    ApplicationArea = All;
                }
                field("Duration in Month"; Rec."Duration in Month")
                {
                    Caption = 'Duration in Month';
                    ApplicationArea = All;
                }
                field("Number of Semesters"; Rec."Number of Semesters")
                {
                    ToolTip = 'Number of Semesters';
                    Caption = 'Number of Semesters';
                    ApplicationArea = All;
                }
                field("Academic SAP"; Rec."Academic SAP")
                {
                    ToolTip = 'Academic SAP';
                    Caption = 'Academic SAP';
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ToolTip = 'Capacity';
                    ApplicationArea = All;
                }
                field("Credit Required"; Rec."Credit Required")
                {
                    ToolTip = 'Credit Required';
                    ApplicationArea = All;
                }
                field("Attendance Percentage"; Rec."Attendance Percentage")
                {
                    ToolTip = 'Attendance Percentage';
                    ApplicationArea = All;
                }
                field("Enrollment Nos."; Rec."Enrollment Nos.")
                {
                    ApplicationArea = All;
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Taxable';
                    ApplicationArea = All;
                }
                field("Admitted Year Wise Fee"; Rec."Admitted Year Wise Fee")
                {
                    ApplicationArea = All;
                }
                field("Semester Wise Fee"; Rec."Semester Wise Fee")
                {
                    ApplicationArea = All;
                }
                Field("EMT Transcript"; Rec."EMT Transcript")
                {
                    ApplicationArea = all;
                    //Visible = "Global Dimension 1 Code" = '9100';
                }
                Field("Advance Course(EMT)"; Rec."Advance Course(EMT)")
                {
                    ApplicationArea = All;
                    //Visible = "Global Dimension 1 Code" = '9100';
                }
                field("Financial AID Applicable"; Rec."Financial AID Applicable")
                {
                    ApplicationArea = All;
                }
                field("Lateral Entry Allowed"; Rec."Lateral Entry Allowed")
                {
                    ApplicationArea = all;
                }
                field("Clinical Clerkship Applicable"; Rec."Clinical Clerkship Applicable")
                {
                    ApplicationArea = all;
                }
                field("Honors Applicable"; Rec."Honors Applicable")
                {
                    ApplicationArea = all;
                }
                field("Min CGPA Required"; Rec."Min CGPA Required")
                {
                    ApplicationArea = all;
                }
                Field("Logo Image"; Rec."Logo Image")
                {
                    ApplicationArea = All;
                }
                Field("Transcript Data Filter"; Rec."Transcript Data Filter")
                {
                    ApplicationArea = All;
                }
                Field("Non Degree"; Rec."Non Degree")
                {
                    ApplicationArea = All;
                }
                Field("Show Grade Description"; Rec."Show Grade Description")
                {
                    ApplicationArea = All;
                }
                Field("Course Change Allowed"; Rec."Course Change Allowed")
                {
                    ApplicationArea = All;
                }
                field("OLR Applicable"; Rec."OLR Applicable")
                {
                    ApplicationArea = all;
                }
                Field("New OLR Enabled"; Rec."New OLR Enabled")
                {
                    ApplicationArea = All;

                }
                Field("Returning OLR Enabled"; Rec."Returning OLR Enabled")
                {
                    ApplicationArea = All;
                }
            }

            group("Application Detail")
            {

                Caption = 'Application Detail';
                Visible = false;
                field("Application Cost For Reserve"; Rec."Application Cost For Reserve")
                {
                    ToolTip = 'Application Cost For Reserve';
                    ApplicationArea = All;
                }
                field("Application Cost For Others"; Rec."Application Cost For Others")
                {
                    ToolTip = 'Application Cost For Others';
                    ApplicationArea = All;
                }
                field("Registration Cost For Reserve"; Rec."Registration Cost For Reserve")
                {
                    ToolTip = 'Registration Cost For Reserve';
                    ApplicationArea = All;
                }
                field("Registration Cost For Others"; Rec."Registration Cost For Others")
                {
                    ToolTip = 'Registration Cost For Others';
                    ApplicationArea = All;
                }
                field("Age As on Date"; Rec."Age As on Date")
                {
                    ToolTip = 'Age As on Date';
                    ApplicationArea = All;
                }
                field("Minimum Age Limit"; Rec."Miniimum Age Limit")
                {
                    ToolTip = 'Minimum Age Limit';
                    ApplicationArea = All;
                    Caption = 'Minimum Age Limit';
                }
                field("Maximum Age Limit"; Rec."Maximum Age Limit")
                {
                    ToolTip = 'Maximum Age Limit';
                    ApplicationArea = All;
                }
                field("Application Sale From"; Rec."Application Sale From")
                {
                    ToolTip = 'Application Sale From';
                    ApplicationArea = All;
                }
                field("Application Sale Till"; Rec."Application Sale Till")
                {
                    ToolTip = 'Application Sale Till';
                    ApplicationArea = All;
                }
                field("Application Receive From"; Rec."Application Receive From")
                {
                    ToolTip = 'Application Receive From';
                    ApplicationArea = All;
                }
                field("Application Receive Till"; Rec."Application Receive Till")
                {
                    ToolTip = 'Application Receive Till';
                    ApplicationArea = All;
                }
                field("Total Credit"; Rec."Total Credit")
                {
                    ToolTip = 'Total Credit';
                    ApplicationArea = All;
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Reset OLR Information")
            {
                action("Reset OLR Information(New Students)")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Trigger OnAction()
                    var
                        HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                        StudentType: Option " ",New,Returning;
                    Begin
                        Rec.TestField("New OLR Enabled");
                        If Confirm('Do you want to reset OLR information for all the New Student whose Course : %1?', true, Rec.Code) then begin
                            HoldBulkUpload_lCU.ResetStudentforOLR(Rec.Code, StudentType::New);

                            Message('New Student OLR have been reset.');
                        end;


                    End;
                }
                action("Reset OLR Information(Returning Students)")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Trigger OnAction()
                    var
                        HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                        StudentType: Option " ",New,Returning;
                    Begin
                        Rec.TestField("Returning OLR Enabled");
                        If Confirm('Do you want to reset OLR information for all the Returning Student whose Course : %1?', true, Rec.Code) then begin
                            HoldBulkUpload_lCU.ResetStudentforOLR(Rec.Code, StudentType::Returning);
                            Message('Returning Student OLR have been reset.');
                        end;


                    End;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                /*   action("Set Eligible Formula")
                   {
                       ToolTip = 'Set Eligible Formula';
                       Caption = 'Set Stage&1 Formula';
                       Image = AddAction;
                       ApplicationArea = All;
                   }
                   action("Set Ranking Formula")
                   {
                       ToolTip = 'Set Ranking Formula';
                       Caption = 'Set Stage&2 Formula';
                       Image = AddAction;
                       ApplicationArea = All;
                   }*/
                action("Elective Subject Group Wise")
                {
                    ToolTip = 'Elective Subject Group Wise';
                    Image = List;
                    RunObject = page "Group (Elec. Course) List_CS";
                    RunPageLink = "Course Code" = FIELD("Code");
                    RunPageView = SORTING("Course Code", "Elective Group Code");
                    ApplicationArea = All;
                }
            }
            group("&Course")
            {
                Caption = '&Course';
                separator("-")
                {
                    Caption = '-';
                }
                action("&Course Grade")
                {
                    ToolTip = '&Course Grade';
                    Caption = '&Course Grade';
                    Image = List;
                    RunObject = Page "Course Grade -CS";
                    RunPageLink = Course = FIELD(Code);
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Section)
                {
                    ToolTip = 'Section';
                    Caption = 'Section';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Course Section Detail-CS";
                    RunPageLink = "Course Code" = FIELD("Code");
                    ApplicationArea = All;
                }
                action("Course Su&bjects")
                {
                    ToolTip = 'Course Su&bjects';
                    Caption = 'Course Su&bjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Course Subject H Detail-CS";
                    RunPageLink = "Course" = FIELD("Code");
                    ApplicationArea = All;
                }
                action("Course Degree")
                {
                    Caption = 'Course Degree';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Course Degree";
                    // RunPageLink = "Course Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Course Optional Subjects")
                {
                    ToolTip = 'Course Optional Subjects';
                    Caption = 'Course CBCS S&ubjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::23-05-2019: Start
                        AcademicsSetupCS.GET();
                        AcademicsSetupCS.TESTFIELD("Common Subject Type");
                        SubjectMasterCS.RESET();
                        SubjectMasterCS.SETFILTER("Subject Type", '<>%1', AcademicsSetupCS."Common Subject Type");
                        SubjectMasterCS.SETFILTER(Course, '%1|%2', Rec.Code, '');
                        IF "PAGE".RUNMODAL(Page::"Subject Detail -CS", SubjectMasterCS) = ACTION::LookupOK THEN;
                        //Code added for Page Run::CSPL-00092::23-05-2019: End
                    end;
                }
                action("C&ourse Semester")
                {
                    ToolTip = 'Course Semester';
                    Caption = 'C&ourse Semester';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::23-05-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            CourseSemMasterCS.Reset();
                            CourseSemMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF "PAGE".RUNMODAL(Page::"Semester Course-CS", CourseSemMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is Year basis course');
                        //Code added for Page Run::CSPL-00092::23-05-2019: End
                    end;
                }
                action("Course &Year")
                {
                    ToolTip = 'Course &Year';
                    Caption = 'Course &Year';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::23-05-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            CourseYearMasterCS.RESET();
                            CourseYearMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF "PAGE".RUNMODAL(Page::"Year Course-CS", CourseYearMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is semester basis course');
                        //Code added for Page Run::CSPL-00092::23-05-2019: End
                    end;
                }
                action("Course Wise Faculty")
                {
                    ToolTip = 'Course Wise Faculty';
                    Caption = 'Course Wise Faculty';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Faculty-Course Wise";
                    RunPageLink = "Course Code" = FIELD("Code");
                    ApplicationArea = All;
                }
                action(Prequalifications)
                {
                    ToolTip = 'Prequalifications';
                    Caption = 'Prequalifications';
                    RunObject = Page "Slot(Exam) Card-CS";
                    //RunPageLink = "Field10" = FIELD("Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Generate Course Semester")
                {
                    Image = Create;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    // trigger OnAction()
                    // Var
                    //     SemesterTempList: Page "Semester Temp List";
                    // begin
                    //     SemesterTempList.VariablePassing(Rec.Code, Rec."Global Dimension 1 Code");
                    //     SemesterTempList.RunModal();
                    // end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for Condition based Flag true or false::CSPL-00092::23-05-2019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for Condition based Flag true or false::CSPL-00092::23-05-2019: Start
    end;

    trigger OnOpenPage()
    begin
        //Code added for Flag true::CSPL-00092::23-05-2019: Start
        EditableBTNSEM := TRUE;
        EditableBTNYR := TRUE;
        //Code added for Flag true::CSPL-00092::23-05-2019: End
    end;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        CourseYearMasterCS: Record "Course Year Master-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;

}