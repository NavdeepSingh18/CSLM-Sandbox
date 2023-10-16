table 50177 "Scholarship Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   26/05/2019       OnInsert()                                 Get "No Series","User Id" Values
    // 02    CSPL-00114   26/05/2019       OnDelete()                                 Code added for Lines Deleted
    // 03    CSPL-00114   26/05/2019       No. - OnValidate()                         Code added for Status Related
    // 04    CSPL-00114   26/05/2019       Scholarship Code - OnValidate()            Code added for Scholarship Name & Fee Classification value
    // 05    CSPL-00114   26/05/2019       Source Code - OnValidate()                 Code added for Source name from Scholar Source
    // 06    CSPL-00114   26/05/2019       AssistEdit()- Function                     Code added for No Series generation

    Caption = 'Scholarship Header-CS';
    DrillDownPageID = "Scholarshpt List-CS";
    LookupPageID = "Scholarshpt List-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = true;

            trigger OnValidate()
            begin
                UserSetup.Get(UserId());
                //Code added for No Series::CSPL-00114::26052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    "FeeSetupCS".Reset();
                    "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    IF FeeSetupCS.FindFirst() then begin
                        NoSeriesMgt.TestManual(FeeSetupCS."Scholarship Detail No.");
                        "No. Series" := '';
                    End;
                END;
                //Code added for No Series::CSPL-00114::26052019: End
            end;
        }
        field(2; "Scholarship Code"; Code[10])
        {
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";

            trigger OnValidate()
            begin
                //Code added for Scholarship Name & Fee Classification value::CSPL-00114::26052019: Start
                CategoryMasterCS.Reset();
                CategoryMasterCS.SETRANGE(Code, "Scholarship Code");
                IF CategoryMasterCS.FINDFIRST() THEN BEGIN
                    "Scholarship Name" := CategoryMasterCS.Description;
                    "Fee Classification Code" := CategoryMasterCS."Fee Classification";
                END;
                //Code added for Scholarship Name & Fee Classification value::CSPL-00114::26052019: End
            end;
        }
        field(3; "Scholarship Name"; Text[50])
        {
            Caption = 'Scholarship Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS".Code;

            trigger OnValidate()
            begin
                //Code added for Source name from Scholar Source::CSPL-00114::26052019: Start
                IF SourceScholarshipCS.GET("Source Code") THEN begin
                    "Source Name" := SourceScholarshipCS.Description;
                    "Discount Type" := SourceScholarshipCS."Discount Type";
                    "SAP Code" := SourceScholarshipCS."SAP Code";
                end else begin
                    "Source Name" := '';
                    "Discount Type" := "Discount Type"::" ";
                    "SAP Code" := '';
                end;
                //Code added for Source name from Scholar Source::CSPL-00114::26052019: End
                CheckDuplicate(Rec);

                if ("Source Code" <> '') and ("Source Code" <> xRec."Source Code") then begin
                    // if Confirm(Text001Lbl, false) then begin
                    // end else
                    //    exit;

                    ScholarshipLineCS.Reset();
                    ScholarshipLineCS.SetRange("Document No.", "No.");
                    if ScholarshipLineCS.FindSet() then
                        Repeat
                            ScholarshipLineCS.Validate(ScholarshipLineCS."Source Code", "Source Code");
                            ScholarshipLineCS.Modify();
                        until ScholarshipLineCS.Next() = 0;
                end;
            end;

        }
        field(5; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Fee Classification Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Admitted Year"; Code[10])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            trigger OnValidate();
            begin
                CheckDuplicate(Rec);

            end;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID"';
            DataClassification = CustomerContent;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(10; "Course Code"; Code[10])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate();
            begin
                CheckDuplicate(Rec);

            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = "G/L Account";
        }
        field(50004; "Discount Type"; option)
        {
            DataClassification = CustomerContent;
            Caption = 'Discount Type';
            OptionCaption = ' ,Grant,Scholarship';
            OptionMembers = " ","Grant","Scholarship";
            Editable = false;
        }
        field(50005; "Grant Criteria"; Option)
        {
            Caption = 'Grant Criteria';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Antiguan,Montserrat,Sibling/Spouse';
            OptionMembers = " ",Antiguan,Montserrat,"Sibling/Spouse";
        }
        field(50006; "SAP Code"; Code[20])
        {
            Caption = 'SAP Code';
            DataClassification = CustomerContent;
            TableRelation = "SAP Fee Code";
            Editable = false;
        }
        field(50007; "Insert Sync"; Integer)
        {
            Caption = 'Insert Sync';
            DataClassification = CustomerContent;

            Editable = false;
            MaxValue = 99;
            MinValue = 0;

        }
        field(50008; "Update Sync"; Integer)
        {
            Caption = 'Update Sync';
            DataClassification = CustomerContent;

            Editable = false;
            MaxValue = 99;
            MinValue = 0;

        }
        field(50009; "Inserted In SalesForce"; Boolean)
        {
            Caption = 'Inserted In SalesForce';
            DataClassification = CustomerContent;
            Editable = false;

        }

        field(50010; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(50011; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        //Code added for Code added for Lines Deleted ::CSPL-00114::26052019: Start
        if "Source Code" <> '' then begin
            CLE.Reset();
            CLE.SETRANGE("Waiver/Scholar/Grant Code", "Source Code");
            CLE.SetRange("Admitted Year", "Admitted Year");
            CLE.SETRANGE(CLE.Reversed, FALSE);
            if CLE.FindFirst() then
                Error('You can not delete the record, Ledger Entry already exist');
        end;

        ScholarshipLineCS.Reset();
        ScholarshipLineCS.SETRANGE("Document No.", "No.");
        IF ScholarshipLineCS.FINDSET() THEN
            ScholarshipLineCS.DELETEALL();
        //Code added for Code added for Lines Deleted ::CSPL-00114::26052019: End
    end;

    trigger OnInsert()
    begin
        UserSetup.Get(UserId());
        //Code added for Get "No Series","User Id" Values ::CSPL-00114::26052019: Start
        "FeeSetupCS".Reset();
        "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF FeeSetupCS.FindFirst() then begin
            IF "No. Series" = '' THEN BEGIN
                FeeSetupCS.TESTFIELD(FeeSetupCS."Scholarship Detail No.");
                NoSeriesMgt.InitSeries(FeeSetupCS."Scholarship Detail No.", xRec."No. Series", 0D, "No.", "No. Series");
            END;
        End;
        "User ID" := FORMAT(UserId());
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";

        Inserted := True;

        //  Validate("Scholarship Code", 'DEFAULT');

        //Code added for Get "No Series","User Id" Values ::CSPL-00114::26052019: End
    end;

    Trigger OnModify()
    Begin
        if xRec.Updated = Updated then
            Updated := true;
    End;

    var
        CategoryMasterCS: Record "Category Master-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        UserSetup: Record "User Setup";
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        SourceScholarshipCS: Record "Source Scholarship-CS";
        ScholarshipLineCS: Record "Scholarship Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    //        Text001Lbl: Label 'You have changed the Source Code, Do you want to update the Source Code on the existing Scholarship lines.\';


    procedure AssistEdit(OldScholarshipHeaderCS: Record "Scholarship Header-CS"): Boolean
    var
        UserSetupRec: Record "User Setup";
    begin
        //Code added for No Series Generation::CSPL-00114::26052019: Start
        UserSetupRec.Get(UserId());
        WITH ScholarshipHeaderCS DO BEGIN
            ScholarshipHeaderCS := Rec;
            "FeeSetupCS".Reset();
            "FeeSetupCS".SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            IF FeeSetupCS.FindFirst() then begin
                FeeSetupCS.TESTFIELD(FeeSetupCS."Scholarship Detail No.");
                IF NoSeriesMgt.SelectSeries(FeeSetupCS."Scholarship Detail No.", OldScholarshipHeaderCS."No. Series", "No. Series") THEN BEGIN
                    NoSeriesMgt.SetSeries("No.");
                    Rec := ScholarshipHeaderCS;
                    EXIT(TRUE);
                END;
            end;
        END;
        //Code added for No Series Generation::CSPL-00114::26052019: End
    end;

    procedure CheckDuplicate(OldScholarshipHeaderCS: Record "Scholarship Header-CS"): Boolean
    begin
        ScholarshipHeaderCS.Reset();
        ScholarshipHeaderCS.Setrange("Source Code", "Source Code");
        ScholarshipHeaderCS.Setrange("Admitted Year", "Admitted Year");
        ScholarshipHeaderCS.Setrange("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF ScholarshipHeaderCS.FindFirst() then
            Error('Same Setup already Exists');
    end;
}

