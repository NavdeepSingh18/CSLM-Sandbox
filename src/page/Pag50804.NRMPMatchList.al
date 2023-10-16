page 50804 "NRMP Match List"
{
    Caption = 'NRMP Match List Upload';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "NRMP Match List";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field(ECFMG_ID; Rec.ECFMG_ID)
                {
                    ApplicationArea = All;

                }
                field(SCHOOL_CD; Rec.SCHOOL_CD)
                {
                    ApplicationArea = All;

                }
                field(SCHOOL_NAME; Rec.SCHOOL_NAME)
                {
                    ApplicationArea = All;

                }
                field(FNAME; Rec.FNAME)
                {
                    ApplicationArea = All;

                }
                field(MNAME; Rec.MNAME)
                {
                    ApplicationArea = All;

                }
                field(LNAME; Rec.LNAME)
                {
                    ApplicationArea = All;

                }
                field(USER_TYPE_CD; Rec.USER_TYPE_CD)
                {
                    ApplicationArea = All;

                }
                field(MATCH_STATUS_CD; Rec.MATCH_STATUS_CD)
                {
                    ApplicationArea = All;

                }
                field(PGY1_INST_NAME; Rec.PGY1_INST_NAME)
                {
                    ApplicationArea = All;

                }
                field("Hospital State 1"; Rec."Hospital State 1")
                {
                    ApplicationArea = All;

                }
                field(PGY1_PGM_NAME; Rec.PGY1_PGM_NAME)
                {
                    ApplicationArea = All;

                }
                field(PGY1_PGM_CD; Rec.PGY1_PGM_CD)
                {
                    ApplicationArea = All;

                }
                field(PGY2_INST_NAME; Rec.PGY2_INST_NAME)
                {
                    ApplicationArea = All;

                }
                field("Hospital State 2"; Rec."Hospital State 2")
                {
                    ApplicationArea = All;

                }
                field(PGY2_PGM_NAME; Rec.PGY2_PGM_NAME)
                {
                    ApplicationArea = All;

                }
                field(PGY2_PGM_CD; Rec.PGY2_PGM_CD)
                {
                    ApplicationArea = All;

                }
                field(MATCH_YR; Rec.MATCH_YR)
                {
                    ApplicationArea = All;

                }

                field(Generated; Rec.Generated)
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;

                }
                field("Creation On"; Rec."Creation On")
                {
                    ApplicationArea = All;

                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;

                }
                field("Modified On"; Rec."Modified On")
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
            group("Action")
            {

                Caption = 'Action';
                action("Student List")
                {
                    ApplicationArea = All;
                    Caption = 'Student List';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = List;
                    RunObject = page "Student List for Residency";
                }
                action("Generate")
                {
                    ApplicationArea = All;
                    Caption = 'Generate';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Post;
                    trigger OnAction()
                    begin
                        NRMPRec.Reset();
                        NRMPRec.SetCurrentKey(ECFMG_ID);
                        NRMPRec.SetRange(Generated, false);
                        if NRMPRec.FindFirst() then begin
                            repeat
                                StudentMasterRec.Reset();
                                StudentMasterRec.SetRange(UsmleID, NRMPRec.ECFMG_ID);
                                if StudentMasterRec.FindFirst() then begin

                                    StudentResidency.Init();
                                    UserSetup.Get(UserId());
                                    EducationSetupRec.Reset();
                                    //EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                                    if EducationSetupRec.FindFirst() then begin
                                        StudentResidency."Residency No." := NoSeriesMgt.GetNextNo(EducationSetupRec."Residency Nos.", 0D, TRUE);
                                    end;
                                    StudentResidency.Validate(StudentResidency."Student No.", StudentMasterRec."No.");
                                    StudentResidency.Validate(StudentResidency."Residency Year", NRMPRec.MATCH_YR);
                                    StudentResidency."First Name" := NRMPRec.FNAME;
                                    StudentResidency."Last Name" := NRMPRec.LNAME;
                                    StudentResidency."Student Name" := StudentMasterRec."Student Name";
                                    StudentResidency."Enrollment No." := StudentMasterRec."Enrollment No.";
                                    StudentResidency."NRMP Status" := Format(NRMPRec.MATCH_STATUS_CD);
                                    StudentResidency."CaRMS Status" := '';
                                    StudentResidency."San Francisco Status" := '';
                                    StudentResidency."Hospital Name1" := NRMPRec.PGY1_INST_NAME;
                                    StudentResidency."Residency Specialty1" := NRMPRec.PGY1_PGM_NAME;
                                    StudentResidency."Hospital State1" := NRMPRec."Hospital State 1";
                                    StudentResidency."Hospital City1" := '';
                                    StudentResidency."Hospital Country1" := '';
                                    StudentResidency."Hospital Name2" := NRMPRec.PGY2_INST_NAME;
                                    StudentResidency."Residency Specialty2" := NRMPRec.PGY2_PGM_NAME;
                                    StudentResidency."Hospital State2" := NRMPRec."Hospital State 2";
                                    StudentResidency."Hospital City2" := '';
                                    StudentResidency."Hospital Country2" := '';
                                    Evaluate(Year, NRMPRec.MATCH_YR);
                                    StudentResidency."Residency Effective Date" := DMY2Date(01, 07, Year);
                                    if NRMPRec.MATCH_STATUS_CD = NRMPRec.MATCH_STATUS_CD::CERTIFIED then begin
                                        if (NRMPRec.PGY1_INST_NAME = '') and (NRMPRec.PGY2_INST_NAME = '') then
                                            StudentResidency.Validate("Residency Status", 'NO MATCHED')
                                        else
                                            StudentResidency.Validate("Residency Status", 'MATCHED');
                                    end;
                                    if (NRMPRec.MATCH_STATUS_CD = NRMPRec.MATCH_STATUS_CD::INITIAL) or
                                    (NRMPRec.MATCH_STATUS_CD = NRMPRec.MATCH_STATUS_CD::REGISTERED) then
                                        StudentResidency.Validate("Residency Status", 'OPTED-OUT');

                                    if NRMPRec.MATCH_STATUS_CD = NRMPRec.MATCH_STATUS_CD::WITHDRAWN then
                                        StudentResidency.Validate("Residency Status", 'WITHDRAWN');
                                    if NRMPRec.PGY2_INST_NAME <> '' then begin
                                        StudentResidency."Hospital Name" := NRMPRec.PGY2_INST_NAME;
                                        StudentResidency."Residency Specialty" := NRMPRec.PGY2_PGM_NAME;
                                        StudentResidency."Hospital State" := NRMPRec."Hospital State 2";
                                        StudentResidency."Hospital Country" := '';
                                        StudentResidency."Hospital City" := '';
                                    end else begin
                                        StudentResidency."Hospital Name" := NRMPRec.PGY1_INST_NAME;
                                        StudentResidency."Residency Specialty" := NRMPRec.PGY1_PGM_NAME;
                                        StudentResidency."Hospital State" := NRMPRec."Hospital State 1";
                                        StudentResidency."Hospital Country" := '';
                                        StudentResidency."Hospital City" := '';
                                    end;
                                    StudentResidency."Residency Placement Type" := '';
                                    StudentDegree.Reset();
                                    StudentDegree.SetRange("Student No.", StudentMasterRec."No.");
                                    StudentDegree.SetFilter("Degree Code", '%1', 'MD');
                                    if StudentDegree.FindFirst() then begin
                                        if StudentDegree.DateAwarded <> 0D then begin
                                            Year1 := Date2DMY(StudentDegree.DateAwarded, 3);
                                            StudentResidency."Post Graduate Year" := Format(Year1);
                                        end;
                                    end else begin
                                        StudentResidency."Post Graduate Year" := '';
                                    end;
                                    /*
                                    if StudentMasterRec."Date Awarded" <> 0D then begin
                                        Year1 := Date2DMY(StudentMasterRec."Date Awarded", 3);
                                        StudentResidency."Post Graduate Year" := Format(Year1);
                                    end else begin
                                        StudentResidency."Post Graduate Year" := '';
                                    end;
                                    */
                                    StudentResidency."Residency ACGME No." := '';
                                    StudentResidency.ECFMG_ID := NRMPRec.ECFMG_ID;
                                    StudentResidency.Insert(true);
                                    NRMPRec.Delete();
                                end;
                            //end;
                            until NRMPRec.Next() = 0;
                            Message('Student Residency Status List is successfully updated.');
                        end;
                    end;
                }
                action("Upload")
                {
                    ApplicationArea = All;
                    Caption = 'Upload';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    trigger OnAction()
                    begin

                        Xmlport.Run(Xmlport::"NRMP Match List", false, true, Rec);

                    end;
                }


            }
        }
    }
    var
        StudentResidency: Record Residency;
        StudentMasterRec: Record "Student Master-CS";
        NRMPRec: Record "NRMP Match List";
        StudentDegree: Record "Student Degree";
        Year: Integer;
        Year1: Integer;

        EducationSetupRec: Record "Education Setup-CS";

        UserSetup: Record "User Setup";

        NoSeriesMgt: Codeunit NoSeriesManagement;





}