page 50897 "Degree Audit Approved Rejected"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Degree Audit";
    Caption = 'Approved Rejected Degree Audit Card';
    DataCaptionFields = "Application No.", "Student Name";
    Editable = false;
    DelayedInsert = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {

            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }

                field("Personal E-Mail Address"; Rec."Personal E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Permanent Phone No."; Rec."Permanent Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Current Zip Code"; Rec."Current Zip Code")
                {
                    ApplicationArea = All;
                }
                field("Current City"; Rec."Current City")
                {
                    ApplicationArea = All;
                }
                field("Current State"; Rec."Current State")
                {
                    ApplicationArea = All;
                }
                field("Current Country Code"; Rec."Current Country Code")

                {
                    ApplicationArea = All;
                }
                field("Permanent Address"; Rec."Permanent Address")
                {
                    Caption = 'Permanent Address';
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Permanent Zip Code"; Rec."Permanent Zip Code")
                {
                    ApplicationArea = All;
                }
                field("Permanent City"; Rec."Permanent City")
                {
                    ApplicationArea = All;
                }
                field("Permanent State"; Rec."Permanent State")
                {
                    ApplicationArea = All;
                }
                field("Permanent Country Code"; Rec."Permanent Country Code")

                {
                    ApplicationArea = All;
                }

                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
            }
            group("Academic Details")
            {
                field("Last Date of Attendance"; Rec.LDA)
                {
                    ApplicationArea = All;
                }
                field("Estimated Graduation Date"; Rec."Estimated Graduation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = All;
                }

                field("BSIC Opt-Out"; Rec."BSIC Opt-Out")
                {
                    ApplicationArea = All;
                }
                field("Total Clerkship Weeks"; Rec."Total Clerkship Weeks")
                {
                    ApplicationArea = All;
                }
                field("Clinical Curriculum"; Rec."Clinical Curriculum")
                {
                    ApplicationArea = All;
                }

            }
            part(DegreeAuditSubPage; "Degree Audit Documents")
            {
                SubPageLink = "SLcM Document No" = FIELD("Application No.");
                ApplicationArea = All;
                Visible = false;
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
                    // PromotedCategory = Process;
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


            action("Student Degree")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Degree';
                Runobject = page "Student Degree";
                RunPageLink = "Student No." = FIELD("Student No.");
            }

            action("Rotation Audit")
            {
                ApplicationArea = All;
                Image = List;
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
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject Exam';
                Runobject = page "Student Subject Exam List";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
            action("Student Subject")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject List';
                Runobject = page "Student Details-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
        }
    }

}

