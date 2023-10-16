page 50811 "Residency List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Residency;
    SourceTableView = sorting("Residency No.") order(descending);
    CardPageId = "Residency Card";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Residency No."; Rec."Residency No.")
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                Field("Student Current Status"; Rec."Student Current Status")
                {
                    ApplicationArea = All;
                }

                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(ECFMG_ID; Rec.ECFMG_ID)
                {
                    ApplicationArea = All;
                }
                Field("E-mail Address"; Rec."E-mail Address")
                {
                    ApplicationArea = All;
                }
                Field("Residency ACGME No."; Rec."Residency ACGME No.")
                {
                    ApplicationArea = All;
                }
                field("Residency Effective Date"; Rec."Residency Effective Date")
                {
                    ApplicationArea = All;
                }
                field("MSPE Request Date"; Rec."MSPE Request Date")
                {
                    ApplicationArea = All;
                }
                field("Residency Year"; Rec."Residency Year")
                {
                    ApplicationArea = All;
                }
                field("Link to Hospital Branch"; Rec."Link to Hospital Branch")
                {
                    ApplicationArea = All;
                }
                field("Residency Status"; Rec."Residency Status")
                {
                    ApplicationArea = All;
                }
                field("NRMP Status"; Rec."NRMP Status")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Status"; Rec."CaRMS Status")
                {
                    ApplicationArea = All;
                }
                field("San Francisco Status"; Rec."San Francisco Status")
                {
                    ApplicationArea = All;
                }
                field("Residency Placement Type"; Rec."Residency Placement Type")
                {
                    ApplicationArea = All;
                }
                field("Post Graduate Year"; Rec."Post Graduate Year")
                {
                    ApplicationArea = All;
                }
                field("Hospital Code"; Rec."Hospital Code")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty"; Rec."Residency Specialty")
                {
                    ApplicationArea = All;
                }
                field("Hospital City"; Rec."Hospital City")
                {
                    ApplicationArea = All;
                }
                field("Hospital State"; Rec."Hospital State")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country"; Rec."Hospital Country")
                {
                    ApplicationArea = All;
                }

                field("Hospital Name1"; Rec."Hospital Name1")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty1"; Rec."Residency Specialty1")
                {
                    ApplicationArea = All;
                }
                field("Hospital City1"; Rec."Hospital City1")
                {
                    ApplicationArea = All;
                }
                field("Hospital State1"; Rec."Hospital State1")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country1"; Rec."Hospital Country1")
                {
                    ApplicationArea = All;
                }

                field("Hospital Name2"; Rec."Hospital Name2")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty2"; Rec."Residency Specialty2")
                {
                    ApplicationArea = All;
                }
                field("Hospital City2"; Rec."Hospital City2")
                {
                    ApplicationArea = All;
                }
                field("Hospital State2"; Rec."Hospital State2")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country2"; Rec."Hospital Country2")
                {
                    ApplicationArea = All;
                }
                field("File Complete"; Rec."File Complete")
                {
                    ApplicationArea = All;
                }
                field("RPR Rcvd"; Rec."RPR Rcvd")
                {
                    ApplicationArea = All;
                }
                field("Link to Contact"; Rec."Link to Contact")
                {
                    ApplicationArea = All;
                }

                field(nID; Rec.nID)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {

            part("Residency Fact Box"; "Residency Fact Box")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("Student No."), "Residency No." = field("Residency No.");
            }

            part("Residency Note"; "Residency Note")
            {
                ApplicationArea = All;
                SubPageLink = "Source No." = FIELD("Residency No.");
            }

        }

    }

    actions
    {
        area(Processing)
        {
            Action("Export Batch Transcript")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    UserSetup_lRec: Record "User Setup";
                    NMIPasswordInput: Page "Input Data";
                    StudentList_lPage: Page "Student Details-CS";
                    Selection: Integer;
                    InstituteCodeQuest: Label '&Official,U&nofficial';
                    DefaultOption: Integer;
                    FilePath: Text;
                    AcadYear: Code[20];
                Begin
                    FilePAth := '\\10.2.108.135\BulkTranscript';
                    UserSetup_lRec.Reset();
                    UserSetup_lRec.SetRange("User ID", UserId());
                    If UserSetup_lRec.FindFirst() then
                        If not UserSetup_lRec."Export Batch Transcript" then
                            Error('You do not have permission to perform this activity.');

                    IF not Confirm('Do you want to export Bulk Transcript?', False) then
                        Exit;

                    Clear(NMIPasswordInput);
                    NMIPasswordInput.SetInputValue(2);
                    IF NMIPasswordInput.RunModal() = Action::OK then begin
                        //FilePath := NMIPasswordInput.GetRequestedPAth();
                        AcadYear := NMIPasswordInput.GetAcadYear();
                    end;
                    If AcadYear = '' then
                        Error('Please select Academic Year');

                    Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                    if Selection > 0 then begin
                        if Selection = 1 then begin
                            //StudentList_lPage.MSPEApplication(Filepath, AcadYear, true, false);//GMCSCOM
                        end else
                            if Selection = 2 then begin
                                // StudentList_lPage.MSPEApplication(FilePath, AcadYear, False, True);//GMCSCOM
                            end;
                    End;
                end;
            }
            action("Residency Notes")
            {
                ApplicationArea = All;
                Caption = 'Residency Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                begin
                    ;
                    Rec.TestField("Student No.");
                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Residency Type.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Note");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Residency Type.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Residency No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Student No.");
                    Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }

            action("Residency Employment Notes")
            {
                ApplicationArea = All;
                Caption = 'Residency Employment Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                begin
                    Rec.TestField("Student No.");
                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Residency Type.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Employement Note");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Residency Employement Note Type.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Residency No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Student No.");
                    Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }
            action("Hospital List")
            {
                ApplicationArea = All;
                // Caption = 'Residency Employment Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Hospital List";
            }

        }

    }
}
