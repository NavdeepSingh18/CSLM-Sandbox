Page 50782 "Student Degree"
{
    Caption = 'Student Degree';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Student Degree";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Degree Code"; Rec."Degree Code")
                {
                    ApplicationArea = All;
                    // NotBlank = True;
                }
                field("Degree Name"; Rec."Degree Name")
                {
                    ApplicationArea = All;
                }

                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Graduation Date"; Rec."Graduation Date")
                {
                    ApplicationArea = All;

                }
                field(DateAwarded; Rec.DateAwarded)
                {
                    ApplicationArea = All;
                }
                field(DateCleared; Rec.DateCleared)
                {
                    ApplicationArea = All;
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
                Field("Printed Date"; Rec."Printed Date")
                {
                    ApplicationArea = All;
                }
                field("Printed By"; Rec."Printed By")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                }

                field("Last Printed Date"; Rec."Last Printed Date")
                {
                    ApplicationArea = All;
                }
                field("Last Printed By"; Rec."Last Printed By")
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


            action("Print Degree")
            {
                Caption = 'Print Degree';
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                Var
                    StudentDegree: Record "Student Degree";
                    AUABHHSCertificate: Report "AUA BHHS Certificate";
                    AUAMasterofHealthScience: Report "AUA Master of Health Science";
                    AUADoctorofMedicineDegree: Report "AUA Doctor of Medicine Degree";
                    AUADoctorofMedicineDegree1: Report "AUA Doctor of Medicine Degree.";
                    AUADoctorofMedicineDegree2: Report "AUA Doctor of Medicine 11_14";
                    AICASAASHSDegree: Report "AICASA ASHS Degree";
                    AICASAEMTBasicAdvanced: Report "AICASA EMT-Basic & Advanced";
                    AICASAASNursingDegree: Report "AICASA AS Nursing Degree";
                    // temp_blob: Codeunit "TempBlob Test";
                    filemgt: codeunit "File Management";
                    Selection: Integer;
                    //InstituteCodeQuest: Label '11 by 17 Paper size,11 by 14 Paper size,8 by 11 Paper size';
                    InstituteCodeQuest: Label '11 X 14 Paper size,8 X 11 Paper size';
                    DefaultOption: Integer;

                    reportname: label '%1_%2 Degree.pdf';
                    out_stream: OutStream;
                    rec_ref: RecordRef;
                begin
                    IF Rec."Degree Code" = 'BAS' then begin
                        AUABHHSCertificate.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                        AUABHHSCertificate.SETTABLEVIEW(Rec);
                        AUABHHSCertificate.RUNMODAL()

                    end;
                    IF Rec."Degree Code" in ['MSHHS', 'MHS'] then begin
                        AUAMasterofHealthScience.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                        AUAMasterofHealthScience.SETTABLEVIEW(Rec);
                        AUAMasterofHealthScience.RUNMODAL()
                    end;

                    IF (Rec."Degree Code" IN ['DOC', 'HDOC']) then begin
                        Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                        If Selection > 0 then begin
                            // If Selection = 1 then begin
                            //     AUADoctorofMedicineDegree1.StudentDegreevariable("Student No.", "Degree Code");
                            //     AUADoctorofMedicineDegree1.SetTableView(Rec);
                            //     AUADoctorofMedicineDegree1.RunModal();
                            // end;
                            If Selection = 1 then begin
                                // temp_blob.CreateOutStream(out_stream, TextEncoding::UTF8);
                                AUADoctorofMedicineDegree2.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                                AUADoctorofMedicineDegree2.SetTableView(Rec);
                                studentdegree.Reset();
                                studentdegree.SetRange("Student No.", Rec."Student No.");
                                studentdegree.SetRange("Degree Code", Rec."Degree Code");
                                if studentdegree.FindFirst() then
                                    rec_ref.GetTable(studentdegree);

                                AUADoctorofMedicineDegree2.SaveAs('', ReportFormat::Pdf, out_stream, rec_ref);
                                // filemgt.BLOBExport(temp_blob, StrSubstNo(reportname, Rec."Student No.", Rec."Degree Code"), true);
                            end;
                            IF Selection = 2 then begin
                                AUADoctorofMedicineDegree.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                                AUADoctorofMedicineDegree.SETTABLEVIEW(Rec);
                                AUADoctorofMedicineDegree.RUNMODAL()
                            end;
                        end;
                    end;
                    IF Rec."Degree Code" = 'PM' then begin
                        AICASAASHSDegree.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                        AICASAASHSDegree.SETTABLEVIEW(Rec);
                        AICASAASHSDegree.RUNMODAL()
                    end;

                    IF (Rec."Degree Code" IN ['EMTAL', 'EMTALREC', 'EMTBL', 'EMTFR', 'EMTPA', 'EMTPD']) then begin
                        AICASAEMTBasicAdvanced.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                        AICASAEMTBasicAdvanced.SETTABLEVIEW(Rec);
                        AICASAEMTBasicAdvanced.RUNMODAL()
                    end;
                    IF Rec."Degree Code" = 'NUR' then begin
                        AICASAASNursingDegree.StudentDegreevariable(Rec."Student No.", Rec."Degree Code");
                        AICASAASNursingDegree.SETTABLEVIEW(Rec);
                        AICASAASNursingDegree.RUNMODAL()
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Student No.");
    end;


}