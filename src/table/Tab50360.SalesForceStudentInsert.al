table 50360 SalesForceStudent
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; ApplicationNo; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; FirstName; text[35])
        {
            DataClassification = CustomerContent;

        }
        field(3; MiddleName; text[30])
        {
            DataClassification = CustomerContent;

        }
        field(4; AcademicYear; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(5; CourseCode; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(6; MobileNo; Text[30])
        {
            DataClassification = CustomerContent;

        }
        field(7; Email; text[30])
        {
            DataClassification = CustomerContent;

        }
        field(8; FeeClassificationCode; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(9; Category; code[20])
        {
            DataClassification = CustomerContent;

        }
        field(10; Gender; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Female,Male;
            OptionCaption = '"", Female, Male';

        }
        field(11; Semester; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(12; DateofJoining; Date)
        {
            DataClassification = CustomerContent;

        }
        field(13; SalesForceNo; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(14; RoomCategory; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category';

        }
        field(15; AdmittedYear; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(16; Year; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(17; GD1; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(18; GD2; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(19; FatherName; Text[40])
        {
            DataClassification = CustomerContent;

        }
        field(20; MotherName; text[40])
        {
            DataClassification = CustomerContent;

        }
        field(21; Citizenship; code[20])
        {
            DataClassification = CustomerContent;

        }
        field(22; Nationality; text[30])
        {
            DataClassification = CustomerContent;

        }
        field(23; PostCode; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(24; PassPortNo; text[20])
        {
            DataClassification = CustomerContent;

        }
        field(25; PassPortExpiryDate; Date)
        {
            DataClassification = CustomerContent;

        }
        field(26; LineNo; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(27; EntryStatus; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Insert,Update,Delete;
            OptionCaption = '"",Insert,Update,Delete';

        }

        field(28; LastName; text[35])
        {
            DataClassification = CustomerContent;

        }
        field(29; id; Guid)
        {
            DataClassification = CustomerContent;

        }
        field(30; DateOfBirth; Date)
        {
            DataClassification = CustomerContent;

        }
        field(31; StudentNo; code[20])
        {
            DataClassification = CustomerContent;

        }
        field(32; EnrollmentNo; code[20])
        {
            DataClassification = CustomerContent;

        }

    }

    keys
    {
        key(PK; SalesForceNo, LineNo)
        {
            Clustered = true;
        }
    }

    var
    //myInt: Integer;

    trigger OnInsert()
    begin
        id := CreateGuid();
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}