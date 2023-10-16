page 50535 "Immigration Document List"
{

    PageType = List;
    SourceTable = "Immigration Document Upload";
    Caption = 'Immigration Document List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Document Category"; Rec."Document Category")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Document Extension"; Rec."Document Extension")
                {
                    ApplicationArea = All;
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }
                field("Document Path"; Rec."Document Path")
                {
                    ApplicationArea = All;
                }
                field("Document Sub Category"; Rec."Document Sub Category")
                {
                    ApplicationArea = All;
                }
                field("Document Update Date"; Rec."Document Update Date")
                {
                    ApplicationArea = All;
                }
                field("Verified Document"; Rec."Verified Document")
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
            action("Mail For Submit Document")
            {
                ApplicationArea = All;
                Caption = 'Mail For Submit Document';
                ShortcutKey = 'F9';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendMail;
                trigger OnAction()
                begin
                    StudentNumber := '';
                    EducationSetup.Reset();
                    If EducationSetup.FindSet() then
                        repeat
                            StudentRegistration.Reset();
                            StudentRegistration.SetCurrentKey(StudentRegistration."Student No");
                            StudentRegistration.SetRange("Academic Year", EducationSetup."Academic Year");
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Immigration);
                            If StudentRegistration.FindSet() then
                                repeat
                                    IF StudentNumber <> StudentRegistration."Student No" Then begin
                                        CountNum := 0;
                                        CountNum1 := 0;
                                        CountNum2 := 0;
                                        CountNum3 := 0;
                                        CountNum4 := 0;
                                        CountNum5 := 0;
                                        CountNum6 := 0;
                                        Studentmaster.Reset();
                                        Studentmaster.SetRange("No.", StudentRegistration."Student No");
                                        IF Studentmaster.FindFirst() then begin
                                            ImmigrationDoc.Reset();
                                            ImmigrationDoc.SetRange("Student No.", Studentmaster."No.");
                                            ImmigrationDoc.SetRange("Academic Year", Studentmaster."Academic Year");
                                            ImmigrationDoc.SetRange(Semester, Studentmaster.Semester);
                                            If ImmigrationDoc.FindSet() then begin
                                                repeat
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Application Form" then
                                                        CountNum1 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Passport Biodata" then
                                                        CountNum2 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Passport Size Photo" then
                                                        CountNum3 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Return Ticket Copy" then
                                                        CountNum4 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Stamp on Arrival Copy" then
                                                        CountNum5 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Visa Copy" then
                                                        CountNum6 := 1;
                                                until ImmigrationDoc.Next() = 0;
                                                CountNum := CountNum1 + CountNum2 + CountNum3 + CountNum4 + CountNum5 + CountNum6;
                                                // If CountNum <> 6 then
                                                //     ImmigrationMail.MailSendforImmigrationDocumentSubmit(Studentmaster."No.");
                                                StudentNumber := Studentmaster."No.";
                                            end;
                                        end;
                                    end;
                                until StudentRegistration.Next() = 0;
                        Until EducationSetup.Next() = 0;
                End;
            }


            action("Mail For Hard Copy")
            {
                ApplicationArea = All;
                Caption = 'Mail For Hard Copy';
                ShortcutKey = 'F9';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendMail;
                trigger OnAction()
                begin
                    StudentNumber := '';
                    EducationSetup.Reset();
                    IF EducationSetup.FindSet() then
                        repeat
                            StudentRegistration.Reset();
                            StudentRegistration.SetCurrentKey(StudentRegistration."Student No");
                            StudentRegistration.SetRange("Academic Year", EducationSetup."Academic Year");
                            StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Immigration);
                            If StudentRegistration.FindSet() then
                                repeat
                                    IF StudentNumber <> StudentRegistration."Student No" Then begin
                                        CountNum := 0;
                                        CountNum1 := 0;
                                        CountNum2 := 0;
                                        CountNum3 := 0;
                                        CountNum4 := 0;
                                        CountNum5 := 0;
                                        CountNum6 := 0;
                                        Studentmaster.Reset();
                                        Studentmaster.SetRange("No.", StudentRegistration."Student No");
                                        IF Studentmaster.FindFirst() then begin
                                            ImmigrationDoc.Reset();
                                            ImmigrationDoc.SetRange("Student No.", Studentmaster."No.");
                                            ImmigrationDoc.SetRange("Academic Year", Studentmaster."Academic Year");
                                            ImmigrationDoc.SetRange(Semester, Studentmaster.Semester);
                                            If ImmigrationDoc.FindSet() then begin
                                                repeat
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Application Form" then
                                                        CountNum1 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Passport Biodata" then
                                                        CountNum2 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Passport Size Photo" then
                                                        CountNum3 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Return Ticket Copy" then
                                                        CountNum4 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Stamp on Arrival Copy" then
                                                        CountNum5 := 1;
                                                    If ImmigrationDoc."Document Category" = ImmigrationDoc."Document Category"::"Visa Copy" then
                                                        CountNum6 := 1;
                                                until ImmigrationDoc.Next() = 0;
                                                CountNum := CountNum1 + CountNum2 + CountNum3 + CountNum4 + CountNum5 + CountNum6;
                                                // If CountNum = 6 then
                                                //     ImmigrationMail.MailSendforImmigrationHardCopySubmit(Studentmaster."No.");
                                                StudentNumber := Studentmaster."No.";
                                            end;
                                        end;
                                    end;
                                until StudentRegistration.Next() = 0;
                        Until EducationSetup.Next() = 0;
                End;
            }

        }
    }
    var
        StudentRegistration: Record "Student Registration-CS";
        ImmigrationDoc: Record "Immigration Document Upload";
        EducationSetup: Record "Education Setup-CS";
        Studentmaster: Record "Student Master-CS";
        ImmigrationMail: Codeunit "Hosusing Mail";
        CountNum: Integer;
        CountNum1: Integer;
        CountNum2: Integer;
        CountNum3: Integer;
        CountNum4: Integer;
        CountNum5: Integer;
        CountNum6: Integer;
        StudentNumber: Code[20];
}