page 50914 "View Students Group New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Group";
    Caption = 'View Student Group';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Filter Students in Group")
            {
                field(GroupCode; GroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Lookup = true;
                    DrillDown = true;


                    trigger OnValidate()
                    var
                        ClinicalGroups: Record Group;
                    begin

                        GroupDescription := '';
                        ClinicalGroups.Reset();
                        ClinicalGroups.SetRange(Code, GroupCode);
                        if ClinicalGroups.FindFirst() then
                            GroupDescription := ClinicalGroups.Description;

                        if GroupCode <> '' then begin
                            Rec.FilterGroup(2);
                            Rec.SetFilter("Groups Code", GroupCode);
                            CurrPage.Update(true);
                            Rec.FilterGroup(0);
                        end else begin

                            //ViewGroupStudent()
                            // else
                            ClearFilters();
                            CurrPage.Update(true);
                        end;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        TempTable: Record "Temp Record";
                        TemTable2: Record "Temp Record";
                        FilterStudentGroup: page "Filter Student Group";

                    begin
                        FilterStudentGroup.GetFilterfromGroup(GroupCode);

                        if GroupCode <> '' then begin
                            Rec.FilterGroup(2);
                            Rec.SetFilter("Groups Code", GroupCode);
                            CurrPage.Update(true);
                            Rec.FilterGroup(0);
                        end else begin

                            //ViewGroupStudent()
                            // else
                            ClearFilters();
                            CurrPage.Update(true);
                        end;

                        GroupDescription := '';
                        TemTable2.Reset();
                        TemTable2.SetRange(Field2, GroupCode);
                        if TemTable2.FindFirst() then
                            GroupDescription := TemTable2.Field11;

                        TempTable.Reset();
                        TempTable.SetRange("Unique ID", UserID());
                        if TempTable.FindSet() then
                            TempTable.DeleteAll();

                    end;
                }
                field(GroupDescription; GroupDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Group Description';
                    Style = Unfavorable;
                    Editable = false;
                    MultiLine = true;
                }
            }
            repeater("Students")
            {
                Editable = false;
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;

                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;

                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;

                }

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("OLR Hold Group"; Rec."OLR Hold Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {

            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    GroupCode := '';
                    GroupDescription := '';
                    ClearFilters();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ClearFilters();
    end;


    procedure ClearFilters()
    begin

        Rec.Reset();
        Rec.FilterGroup(2);
        Rec.FilterGroup(0);
    end;

    procedure ViewGroupStudent()
    var
        StudentClinicalGroup: Record "Student Group";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Group      ############1################\';
    begin
        ClearFilters();
        Rec.FindSet();
        repeat
            WindowDialog.Open('Checking Students.....\' + Text001Lbl);
            WindowDialog.Update(1, GroupCode + ' - ' + Rec."Student No.");

            StudentClinicalGroup.Reset();
            StudentClinicalGroup.SetRange("Groups Code", GroupCode);
            if StudentClinicalGroup.FindFirst() then
                Rec.Mark(true)
            else
                Rec.Mark(false);
        until Rec.Next() = 0;

        WindowDialog.Close();
        Rec.MarkedOnly(true);
        CurrPage.Update(false);
    end;

    var
        GroupCode: Code[2048];
        GroupDescription: Text[50];



}