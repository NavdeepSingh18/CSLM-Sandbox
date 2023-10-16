page 50013 AlumniReportData
{
    PageType = List;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Temp Record";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(Field2; Rec.Field2)
                {
                    Caption = 'Student Number';
                }
                field(Field3; Rec.Field3)
                {
                    Caption = 'Enrollment No.';
                }
                field(Field11; Rec.Field11)
                {
                    Caption = 'First Name';
                }
                field(Field12; Rec.Field12)
                {
                    Caption = 'Last Name';
                }
                field(Field4; Rec.Field4)
                {
                    Caption = 'Gender';
                }
                Field(Field14; Rec.Field14)
                {
                    Caption = 'Nationality';
                }
                field(Field51; Rec.Field51)
                {
                    Caption = 'Ethnicity';
                }
                field(Field7; Rec.Field7)
                {
                    Caption = 'Year of Graduation';
                }
                field(Program; Rec.Program)
                {
                    Caption = 'Residency Year';
                }
                field(Field38; Rec.Field38)
                {
                    Caption = 'Residency Placement Type';
                }
                field(Field39; Rec.Field39)
                {
                    Caption = 'Residency Specialty (Original)';
                }
                Field(Field40; Rec.Field40)
                {
                    Caption = 'Residency Status';
                }
                Field(Field33; Rec.Field33)
                {
                    Visible = False;
                }

                Field(Field32; Rec.Field32)
                {
                    Caption = 'Residency Placement Type Order';
                }
                field(Field44; Rec.Field44)
                {
                    Caption = 'Residency Hospital';
                }
                field(Field46; Rec.Field46)
                {
                    Caption = 'Residency City';
                }
                field(Field47; Rec.Field47)
                {
                    Caption = 'Residency State';
                }
                Field(Field48; Rec.Field48)
                {
                    Caption = 'Residency Country';
                }
                Field(Field49; Rec.Field49)
                {
                    Caption = 'Personal Email';
                }
                Field("Student Last Name"; Rec."Student Last Name")
                {
                    Caption = 'Student Email';
                }
                Field(Field52; Rec.Field52)
                {
                    Caption = 'Cell Phone';
                }
                Field(Field55; Rec.Field55)
                {
                    Caption = 'Other Phone';
                }
                Field(Field64; Rec.Field64)
                {
                    Caption = 'Address';
                }
                Field(Field54; Rec.Field54)
                {
                    Caption = 'City';
                }
                Field(Field58; Rec.Field58)
                {
                    Caption = 'State';
                }
                Field(Field5; Rec.Field5)
                {
                    Caption = 'Post Code';
                }
                Field(Field59; Rec.Field59)
                {
                    Caption = 'Country';
                }
                Field(Field60; Rec.Field60)
                {
                    Caption = 'Student Status';
                }
                Field(Field65; Rec.Field65)
                {
                    Caption = 'PreMed';
                }
                Field(Field66; Rec.Field66)
                {
                    Caption = 'Fiu Rotations';
                }
                Field(Field71; Rec.Field71)
                {
                    Caption = 'Honors';
                }
                Field("Transcript End"; Rec."Transcript End")
                {
                    Caption = 'Residency';
                }
                Field("Enrollment No."; Rec."Enrollment No.")
                {
                    Caption = 'Global Health Track';
                }
                field("Licence Type"; Rec."Licence Type")
                {
                    ApplicationArea = All;
                }
                field("Licence State"; Rec."Licence State")
                {
                    ApplicationArea = All;
                }
                field("Residency Preliminary"; Rec."Residency Preliminary")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnClosePage()
    var
        TempTable: Record "Temp Record";
    Begin
        TempTable.Reset();
        TempTable.SetRange("Unique ID", UserId);
        TempTable.DeleteAll();

    End;
}