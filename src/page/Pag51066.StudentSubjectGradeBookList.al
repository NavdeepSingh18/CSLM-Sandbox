page 51066 StudentSubjectGradeBookList
{
    PageType = List;
    Caption = 'Student Subject Grade Book List';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Subject GradeBook";
    InsertAllowed = false;
    //ModifyAllowed = false;
    DeleteAllowed = false;
    //Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = all;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = all;
                }
                field("Grade To Be Published"; Rec."Grade To Be Published")
                {
                    ApplicationArea = all;
                }
                field("Numeric Grade"; Rec."Numeric Grade")
                {
                    ApplicationArea = all;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = all;
                }
                field("Credit Earned"; Rec."Credit Earned")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Academic Suggestion"; Rec."Academic Suggestion")
                {
                    ApplicationArea = all;
                }
                field("% Range"; Rec."% Range")
                {
                    ApplicationArea = all;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = all;
                    Caption = 'Recommendations / Decision';
                }
                field(Communications; Rec.Communications)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                Field(GPA; Rec.GPA)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Export StudentSubject Grade Book")
            {
                ApplicationArea = All;
                Caption = 'Export StudentSubject Grade Book';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = True;
                trigger OnAction()
                var
                    SSGRadeBook: Record "Student Subject GradeBook";
                    TimeTableLineReport: Report TimetableLine;
                Begin
                    Clear(TimeTableLineReport);
                    SSGRadeBook.Reset();
                    SSGRadeBook.SetRange("Grade Book No.", Rec."Grade Book No.");
                    TimetablelineReport.SetTableView(SSGRadeBook);
                    TimeTableLineReport.DocumentNoFilter(SSGRadeBook."Grade Book No.");
                    TimeTableLineReport.SSGradeBookFilter(true);
                    TimeTableLineReport.Run();

                End;
            }
            action("Import StudentSubject Grade Book")
            {
                ApplicationArea = All;
                Caption = 'Import StudentSubject Grade Book';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = True;
                Trigger OnAction()
                var
                    ImportSSGradeBook: XmlPort ImportStudentSubjectGB;
                Begin
                    Clear(ImportSSGradeBook);
                    ImportSSGradeBook.Run();
                    CurrPage.Update();
                End;
            }
            action("CheckEmail")
            {
                ApplicationArea = All;
                //Caption = 'Import StudentSubject Grade Book';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = True;
                Visible = false;
                Trigger OnAction()
                var
                    ImportSSGradeBook: page 51047;
                Begin
                    Clear(ImportSSGradeBook);
                    ImportSSGradeBook.SemesterPromotionsMail(Rec);
                    //CurrPage.Update();
                End;
            }
        }
    }


}