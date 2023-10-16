table 50464 "Graduation Date Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Graduation Date Master Setup';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                //CSPL-00307-Comt Code for Graduation Date Setup
                // if "No." <> xRec."No." then begin
                //     EducationSetup.Reset();
                //     IF EducationSetup.FindFirst() then;
                //     NoSeriesMgt.TestManual(EducationSetup."Medical Nos.");
                // end;

                if "No." <> xRec."No." then begin
                    EducationSetup.Reset();
                    IF EducationSetup.FindFirst() then;
                    NoSeriesMgt.TestManual(EducationSetup."Graduation Date Setup Nos");
                end;
            end;
        }

        field(2; CreatedBy; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; CreatedOn; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; ModifiedBy; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; ModifiedOn; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Inserted; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Updated; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        ///********CSPL-00307--Start Graduation Date Setup*****************

        field(8; Day_StartDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin

            end;
        }
        field(9; Month_StartDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin
                TestField(Day_StartDate);
            end;
        }
        field(10; Day_EndDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin
                TestField(Day_StartDate);
                TestField(Month_StartDate);
            end;
        }
        field(11; Month_EndDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin
                TestField(Day_StartDate);
                TestField(Month_StartDate);
                TestField(Day_EndDate);
                // IF Month_EndDate < Month_StartDate Then
                //     Error('End Month can not be Less Then Start Date Month');
            end;
        }
        field(12; Day_GraduationDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin

            end;
        }
        field(13; Month_GraduationDate; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin

            end;
        }
        field(14; DegreeCode; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Final Degree-CS";
            trigger OnValidate()
            var
            // myInt: Integer;
            begin

            end;
        }

    }
    ///********CSPL-00307--Start Graduation Date Setup*****************



    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


    trigger OnInsert()
    begin
        //CSPL-00307-Comt Code for Graduation Date Setup
        /*
        IF "No." = '' THEN BEGIN
            EducationSetup.GET;
            EducationSetup.TESTFIELD("Medical Nos.");
            NoSeriesMgt.InitSeries(EducationSetup."Medical Nos.", '', 0D, "No.", EducationSetup."Medical Nos.");
        END;*/

        IF "No." = '' THEN BEGIN
            EducationSetup.Reset();
            IF EducationSetup.FindFirst() then;
            EducationSetup.TESTFIELD("Graduation Date Setup Nos");
            NoSeriesMgt.InitSeries(EducationSetup."Graduation Date Setup Nos", '', 0D, "No.", EducationSetup."Graduation Date Setup Nos");
        END;
    end;


    var
        EducationSetup: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}

