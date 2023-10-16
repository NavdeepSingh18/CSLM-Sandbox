table 50102 "Class Details -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/06/2019       OnInsert()                               Auto Assign user Id
    // 02    CSPL-00114   16/06/2019       LookUpClassCS()                          Create Function Get Class & Curiculum value
    // 03    CSPL-00114   16/06/2019       LookUpCurriculumCS()                     Create Function Get Class & Curiculum value
    // 04    CSPL-00114   16/06/2019       ValidateClassCS()                        Create Function Get Class & Curiculum value
    // 05    CSPL-00114   16/06/2019       ValidateCurriculumCS()                   Create Function Get Class & Curiculum value

    Caption = 'Class Details -CS';
    //DrillDownPageID = 33049252;
    //LookupPageID = 33049252;

    fields
    {
        field(1; "Class Code"; Code[10])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
            SQLDataType = Integer;
            TableRelation = "Class Master - CS";
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup ("Education Setup-CS"."Academic Year");
            Caption = 'Academic Year';

            Editable = false;

        }
        field(5; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
            DataClassification = CustomerContent;
        }
        field(6; "Registration Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost';
            DataClassification = CustomerContent;
        }
        field(15; "Miniimum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Miniimum Age Limit';
            DataClassification = CustomerContent;
        }
        field(16; "Maximum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Maximum Age Limit';
            DataClassification = CustomerContent;
        }
        field(18; "Application Sale From"; Date)
        {
            Caption = 'Application Sale From';
            DataClassification = CustomerContent;
        }
        field(19; "Application Sale Till"; Date)
        {
            Caption = 'Application Sale Till';
            DataClassification = CustomerContent;
        }
        field(20; "Application Receive From"; Date)
        {
            Caption = 'Application Receive From';
            DataClassification = CustomerContent;
        }
        field(21; "Application Receive Till"; Date)
        {
            Caption = 'Application Receive Till';
            DataClassification = CustomerContent;
        }
        field(22; Capacity; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Class Section Master-CS".Capacity WHERE(Class = FIELD("Class Code"),
                                                                        Curriculum = FIELD(Curriculum),
                                                                        "Academic Year" = FIELD(FILTER("Academic Year"))));
            Caption = 'Capacity';

            DecimalPlaces = 0 : 0;
            Editable = false;

        }
        field(23; "Present Strength"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Student Master New-CS" WHERE(Class = FIELD("Class Code"),
                                                  Curriculum = FIELD(Curriculum),
                                                  "Academic Year" = FIELD(FILTER("Academic Year"))));
            Caption = 'Present Strength';

            Editable = false;

        }
        field(24; "Marks System"; Option)
        {
            Caption = 'Marks System';
            DataClassification = CustomerContent;
            OptionCaption = 'Marks,Grade';
            OptionMembers = Marks,Grade;
        }
        field(25; "Promotion Percentage"; Decimal)
        {
            Caption = 'Promotion Percentage';
            DataClassification = CustomerContent;
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(27; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(28; "Cut Off Age as on"; Date)
        {
            Caption = 'Cut Off Age as on';
            DataClassification = CustomerContent;
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
        }
        field(30; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
        }
        field(31; Withdrawal; Integer)
        {
            Caption = 'Withdrawal';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50174; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
        field(50175; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16062019';
        }
    }

    keys
    {
        key(Key1; "Class Code", Curriculum)
        {
        }
        key(Key2; Curriculum, "Class Code")
        {
        }
        key(Key3; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Auto Assign user Id::CSPL-00114::16062019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto Assign user Id::CSPL-00114::16062019: End
    end;

    procedure LookUpClassCS(var getClass: Code[10]; var getCurriculum: Code[10])
    var
        ClassDetailsCSRec: Record "Class Details -CS";
    begin
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: Start
        IF NOT GUIALLOWED() THEN
            EXIT;
        ClassDetailsCSRec."Class Code" := getClass;
        ClassDetailsCSRec.Curriculum := getCurriculum;
        ClassDetailsCSRec.Closed := FALSE;
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: End
    end;

    procedure LookUpCurriculumCS(var getClass: Code[10]; var getCurriculum: Code[10])
    var
        ClassDetailsCSRec: Record "Class Details -CS";
    begin
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: Start
        IF NOT GUIALLOWED() THEN
            EXIT;
        ClassDetailsCSRec.SETCURRENTKEY(Curriculum, "Class Code");
        ClassDetailsCSRec."Class Code" := getClass;
        ClassDetailsCSRec.Curriculum := getCurriculum;
        ClassDetailsCSRec.Closed := FALSE;
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: End
    end;

    procedure ValidateClassCS(var getClass: Code[10]; var getCurriculum: Code[10])
    var
        ClassDetailsCSRec: Record "Class Details -CS";
        ClassDetailsCSRec1: Record "Class Details -CS";
    begin
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: Start
        IF NOT GUIALLOWED() THEN
            EXIT;
        IF getClass <> '' THEN BEGIN
            IF STRPOS(getClass, '*') = STRLEN(getClass) THEN
                ClassDetailsCSRec.SETFILTER("Class Code", getClass)
            ELSE
                ClassDetailsCSRec.SETRANGE("Class Code", getClass);
            IF ClassDetailsCSRec.ISEMPTY() then
                EXIT;
            ClassDetailsCSRec1.COPY(ClassDetailsCSRec);
            IF (ClassDetailsCSRec1.NEXT() = 1) AND GUIALLOWED() THEN
                getClass := ClassDetailsCSRec."Class Code";
            getCurriculum := ClassDetailsCSRec.Curriculum;
        END;
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: End
    end;

    procedure ValidateCurriculumCS(var getClass: Code[10]; var getCurriculum: Code[10])
    var
        ClassDetailsCSRec: Record "Class Details -CS";
        ClassDetailsCSRec1: Record "Class Details -CS";
    begin
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: Start
        IF NOT GUIALLOWED() THEN
            EXIT;
        IF getCurriculum <> '' THEN BEGIN
            IF STRPOS(getCurriculum, '*') = STRLEN(getCurriculum) THEN
                ClassDetailsCSRec.SETFILTER(Curriculum, getCurriculum)
            ELSE
                ClassDetailsCSRec.SETRANGE(Curriculum, getCurriculum);

            IF ClassDetailsCSRec.ISEMPTY() then
                EXIT;
            ClassDetailsCSRec1.COPY(ClassDetailsCSRec);
            IF (ClassDetailsCSRec1.NEXT() = 1) AND GUIALLOWED() THEN
                getClass := ClassDetailsCSRec."Class Code";
            getCurriculum := ClassDetailsCSRec.Curriculum;
        END;
        //Code added for Create Function Get Class & Curiculum value::CSPL-00114::16062019: Start
    end;
}

