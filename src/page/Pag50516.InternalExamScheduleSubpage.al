page 50516 "Internal Exam Schedule Subpage"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Schedule Exam Line';
    DelayedInsert = false;
    PageType = ListPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Exam Time Table Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Select To Generate"; Rec."Select To Generate")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Exam No."; Rec."Exam No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ExamTimeTableHeadCS.Get(Rec."Document No.");
                        CourseSubjectLine.Reset();
                        CourseSubjectLine.SETRANGE("Academic Year", ExamTimeTableHeadCS."Academic Year");
                        CourseSubjectLine.SETRANGE("Global Dimension 1 Code", ExamTimeTableHeadCS."Global Dimension 1 Code");
                        if ExamTimeTableHeadCS."Course Code" <> '' then
                            CourseSubjectLine.SetRange("Course Code", ExamTimeTableHeadCS."Course Code");
                        if ExamTimeTableHeadCS."Semester Code" <> '' then
                            CourseSubjectLine.SetRange(Semester, ExamTimeTableHeadCS."Semester Code");
                        CourseSubjectLine.SETRANGE(Examination, true);
                        CourseSubjectLine.SETRANGE("Level Description", CourseSubjectLine."Level Description"::"External Examination");
                        IF PAGE.RUNMODAL(0, CourseSubjectLine) = ACTION::LookupOK THEN begin
                            Rec.TestField("Exam No.", '');
                            ExamTimeTableLineCS.Reset();
                            ExamTimeTableLineCS.SetRange("Document No.", Rec."Document No.");
                            IF ExamTimeTableLineCS.FindLast() then;
                            Rec."Line No." := ExamTimeTableLineCS."Line No." + 10000;
                            Rec."Subject Code" := CourseSubjectLine."Subject Code";
                            Rec."Subject Name" := CourseSubjectLine.Description;
                            Rec."Subject Group" := CourseSubjectLine."Subject Group";
                            Rec."Subject Type" := CourseSubjectLine."Subject Type";
                            Rec."Subject Class" := CourseSubjectLine."Subject Classification";
                            Rec."Course Code" := CourseSubjectLine."Course Code";
                            Rec."Program" := CourseSubjectLine."Program";
                            Rec."Semester Code" := CourseSubjectLine.Semester;
                            Rec.Year := CourseSubjectLine.Year;
                            Rec."Examiner Type" := ExamTimeTableHeadCS."Exam Type";
                            Rec."Academic Year" := ExamTimeTableHeadCS."Academic Year";
                            Rec."Exam Classification" := ExamTimeTableHeadCS."Exam Classification";
                            Rec."Global Dimension 1 Code" := ExamTimeTableHeadCS."Global Dimension 1 Code";
                            Rec."Term" := ExamTimeTableHeadCS."Term";
                            Rec.LineAutoFill(Rec."Line No.");
                        end;
                        Rec.ValidationCheckCS();
                        CurrPage.Update();
                    end;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                }


                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = all;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }

                field("Exam Slot"; Rec."Exam Slot New")
                {
                    ApplicationArea = All;
                    Caption = 'Exam Slot';

                }

                field("Start Time"; Rec."Start Time New")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Start Time';
                }
                field("End Time"; Rec."End Time New")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'End Time';
                }



            }
        }
    }
    actions
    {
        area(processing)
        {
            group("L&ine")
            {
                action("Select All")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    Caption = 'Select All';
                    Image = Select;

                    trigger OnAction()
                    var
                        ExamTimeLine: Record "Exam Time Table Line-CS";
                    begin
                        if Rec."Document No." <> '' then begin
                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Generate", false);

                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.SetFilter("Exam No.", '%1', '');
                            ExamTimeLine.SetFilter("Exam Date", '<>%1', 0D);
                            ExamTimeLine.SetFilter("Exam Slot New", '<>%1', '');
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Generate", true);
                        end;
                    end;
                }
                action("Deselect All")
                {
                    ApplicationArea = all;
                    Caption = 'Deselect All';
                    Image = RemoveLine;

                    trigger OnAction()
                    var
                        ExamTimeLine: Record "Exam Time Table Line-CS";
                    begin
                        if Rec."Document No." <> '' then begin
                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Generate", false);
                        end;
                    end;
                }
            }
        }

    }
    var
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        CourseSubjectLine: Record "Course Wise Subject Line-CS";

}

