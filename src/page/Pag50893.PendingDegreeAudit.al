page 50893 "Degree Audit list"
{
    PageType = List;
    Caption = 'Pending Degree Audit List';
    UsageCategory = Lists;
    ApplicationArea = All;
    DelayedInsert = false;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Degree Audit Card";
    SourceTable = "Degree Audit";
    DataCaptionFields = "Application No.", "Student Name";
    SourceTableView = sorting("Application No.") order(descending) where("Document Status" = filter("Pending for Verification"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }

                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                }
                field("Last Date of Attendance"; Rec.LDA)
                {
                    ApplicationArea = All;
                }
                field("Estimated Graduation Date"; Rec."Estimated Graduation Date")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date"; Rec."Graduation Date")
                {
                    ApplicationArea = All;
                }

                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Date Awarded"; Rec."Date Awarded")
                {
                    ApplicationArea = All;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {

            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            group(Scores)
            {
                action("CCSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedIsBig = true;
                    // PromotedCategory = Process;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CCSE);
                }
                action("CCSSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedIsBig = true;
                    // PromotedCategory = Process;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CCSSE);
                }
                action("CBSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedIsBig = true;
                    //PromotedCategory = Process;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CBSE);
                }
                action("USMLE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedIsBig = true;
                    // PromotedCategory = Process;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter("STEP 1" | "STEP 2 CK" | "STEP 2 CS");
                }
            }
            action("Rotation Audit")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Rotation Audit';
                Runobject = page "Students Rotation Audit";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Student Subject Exam")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject Exam';
                Runobject = page "Student Subject Exam List";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
            group("Student TranscriptsR1 Print1")
            {
                Caption = 'Student Transcripts Print 1';
                action("Official TranscriptsPrint1")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint1")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print2")
            {
                Caption = 'Student Transcripts Print 2';
                action("Official TranscriptsPrint2")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts1(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint2")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts1(StudentMaster);
                    end;
                }
            }

            group("Student TranscriptsR1 Print3")
            {
                Caption = 'Student Transcripts Print 3';
                action("Official TranscriptsPrint3")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts2(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint3")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts2(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print4")
            {
                Caption = 'Student Transcripts Print 4';
                action("Official TranscriptsPrint4")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts3(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint4")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts3(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print5")
            {
                Caption = 'Student Transcripts Print 5';
                action("Official TranscriptsPrint5")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts4(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint5")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts4(StudentMaster);
                    end;
                }
            }

            group("Student TranscriptsR1 Print6")
            {
                Caption = 'Student Transcripts Print 6';
                action("Official TranscriptsPrint6")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts5(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint6")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts5(StudentMaster);
                    end;
                }
            }
        }
    }
}

