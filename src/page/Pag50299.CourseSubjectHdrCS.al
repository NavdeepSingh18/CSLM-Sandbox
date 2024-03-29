page 50299 "Course Subject Hdr-CS"
{
    // version V.001-CS

    // Sr.No    Emp.ID          Date          Trigger                          Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.      CSPL-00174      01-01-19     OnOpenPage()                    Code added for boolian field false.
    // 02.      CSPL-00174      01-01-19     OnAfterGetRecord()              Code added for editable or non-editable.
    // 03.      CSPL-00174      01-01-19     OnInsertRecord()                Code added for editable or non-editable field.
    // 04.      CSPL-00174      01-01-19     Course - OnValidate()           Code added for editable or non-editable field.
    // 05.      CSPL-00174      01-01-19     Type Of Course - OnValidate()   Code added for editable or non-editable field.
    // 06.      CSPL-00174      01-01-19     Academic Year - OnValidate()    Code added for editable or non-editable field.
    UsageCategory = None;
    Caption = 'Course Subjects';
    PageType = Document;
    SourceTable = "Course Wise Subject Head-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::010119: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::010119: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::010119: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::010119: End
                    end;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::010119: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::010119: End
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    // Editable = EditableBTNYR;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
            part("Course Subject"; 50300)
            {
                ApplicationArea = All;
                SubPageLink = "Course Code" = FIELD("Course"),
                              "Semester" = FIELD("Semester"),
                              "Academic Year" = FIELD("Academic Year"),
                              "Year" = FIELD("Year");
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Copy Course Subject")
            {
                Caption = 'Copy Course Subject';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CourseSubjectRec: Record "Course Wise Subject Head-CS";
                begin
                    CourseSubjectRec.Reset();
                    CourseSubjectRec.SetRange(Course, Rec.Course);
                    CourseSubjectRec.SetRange("Academic Year", Rec."Academic Year");
                    If CourseSubjectRec.FindFirst() then
                        Report.Run(Report::"Copy Course Subject", True, False, CourseSubjectRec);

                end;
            }

            action("Update Student Subject (Core)")
            {
                Caption = '&Update Student Subject (Core)';
                ApplicationArea = All;
                trigger OnAction()
                var
                    RecStudentMasterCs: Record "Student Master-CS";
                    RecReport: Report "Student Subject Update CS";
                begin
                    //CS-ANIKET
                    RecStudentMasterCs.RESET();
                    RecStudentMasterCs.SETRANGE("Course Code", Rec.Course);
                    RecStudentMasterCs.SETRANGE("Academic Year", Rec."Academic Year");
                    RecStudentMasterCs.SETRANGE(Semester, Rec.Semester);
                    RecStudentMasterCs.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    RecStudentMasterCs.SETRANGE(Year, Rec.Year);
                    IF RecStudentMasterCs.FINDFIRST() THEN BEGIN
                        RecReport.SETTABLEVIEW(RecStudentMasterCs);
                        RecReport.RUNMODAL();
                    END;
                    CLEAR(RecReport);
                end;
            }
            action("Course Wise Faculty List")
            {
                ApplicationArea = All;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Faculty-Course Wise";
                RunPageLink = "Course Code" = FIELD(Course);
            }
        }

    }


    trigger OnAfterGetRecord()
    begin
        //Code added for editable or non-editable::CSPL-00174::010119: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for editable or non-editable::CSPL-00174::010119: End
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Code added for editable or non-editable field:CSPL-00174::010119: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for editable or non-editable field::CSPL-00174::010119: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for boolian field false::CSPL-00174::010119: Start
        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;
        //Code added for boolian field false::CSPL-00174::010119: End
    end;

    var
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
}