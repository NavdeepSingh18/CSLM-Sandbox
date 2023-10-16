table 50218 "Daily Attendence Summary-CS"
{
    // version V.001-CS

    Caption = 'Daily Attendence Summary-CS';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Time in"; Time)
        {
            Caption = '';
            DataClassification = CustomerContent;
        }
        field(4; "Time Out"; Time)
        {
            Caption = 'Time in';
            DataClassification = CustomerContent;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Present,Holiday,Off-Day,Leave,LWP(Half-Day),LWP(Full-Day),Special Leave,Absent(Half-Day),Absent(Full-Day)';
            OptionMembers = ,Present,Holiday,"Off-Day",Leave,"LWP(Half-Day)","LWP(Full-Day)","Special Leave","Absent(Half-Day)","Absent(Full-Day)";

            trigger OnValidate()
            var

            begin
            end;
        }
        field(6; "Hours Present"; Decimal)
        {
            Caption = 'Hours Present';
            DataClassification = CustomerContent;
        }
        field(9; "Off Day"; Boolean)
        {
            Caption = 'Off Day';
            DataClassification = CustomerContent;
        }
        field(10; Holiday; Boolean)
        {
            Caption = 'Holiday';
            DataClassification = CustomerContent;
        }
        field(11; "Extra Hours Worked"; Decimal)
        {
            Caption = 'Extra Hours Worked';
            DataClassification = CustomerContent;
        }
        field(13; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Short-Leave","Half-Day","Full-Day";
        }
        field(14; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;
            Editable = true;

            trigger OnValidate()
            var

            begin
            end;
        }
        field(15; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENT'));
        }
        field(20; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Grade Master-CS";
        }
        field(25; Branch; Code[20])
        {
            Caption = 'Branch';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('UNIT'));
        }
        field(30; "Department Filter"; Code[20])
        {
            Caption = 'Department Filter';

            FieldClass = FlowFilter;
        }
        field(33; "Grade Filter"; Code[10])
        {
            Caption = 'Grade Filter';

            FieldClass = FlowFilter;
        }
        field(36; "Branch Filter"; Code[20])
        {
            Caption = 'Branch Filter';

            FieldClass = FlowFilter;
        }
        field(40; hi; Integer)
        {
            Caption = 'hi';
            DataClassification = CustomerContent;
        }
        field(48; "Time Sheet Import"; Boolean)
        {
            Caption = 'Time Sheet Import';
            DataClassification = CustomerContent;
        }
        field(50; "Salary Processed"; Boolean)
        {
            Caption = 'Salary Processed';
            DataClassification = CustomerContent;
        }
        field(60; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
            DataClassification = CustomerContent;
        }
        field(65; "Off Type"; Option)
        {
            Caption = 'Off Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Half-Day","Full-Day";
        }
        field(66; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(67; "Job Title Code"; Code[20])
        {
            Caption = 'Job Title Code';
            DataClassification = CustomerContent;
        }
        field(70; "Late Coming"; Boolean)
        {
            Caption = 'Late Coming';
            DataClassification = CustomerContent;
        }
        field(75; Year; Integer)
        {
            Editable = false;
        }
        field(76; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(90; "OT Approved"; Boolean)
        {
            Caption = 'OT Approved';
            DataClassification = CustomerContent;
        }
        field(100; "Approved Extra Hours Worked"; Decimal)
        {
            Caption = 'Approved Extra Hours Worked';
            DataClassification = CustomerContent;
        }
        field(101; "Leave Compensation"; Boolean)
        {
            Caption = 'Leave Compensation';
            DataClassification = CustomerContent;
        }
        field(102; "Sanctioning Incharge"; Code[20])
        {
            Caption = 'anctioning Incharge';

            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';

            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry";
        }
        field(50001; "Emp Name"; Text[50])
        {
            Caption = 'Emp Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50003; "Weekly Days"; Text[30])
        {
            Caption = 'Weekly Days';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50005; "Sales Office"; Code[13])
        {
            Caption = 'Sales Office';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(50021; "Employee Leave Date"; Date)
        {
            Caption = 'Employee Leave Date';

            Description = 'CS Field Added 26052019';
            FieldClass = FlowField;
        }
        field(60000; "Leave Period"; Date)
        {
            Caption = 'Leave Period';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            TableRelation = Date;
        }
        field(60001; "Previous Status"; Option)
        {
            Caption = 'Previous Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            OptionCaption = ' ,Present,Holiday,Off-Day,Leave,LWP(Half-Day),LWP(Full-Day)';
            OptionMembers = " ",Present,Holiday,"Off-Day",Leave,"LWP(Half-Day)","LWP(Full-Day)";
        }
        field(60002; "Updated After Salary Posted"; Boolean)
        {
            Caption = 'Updated After Salary Posted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60003; "Leave Day"; Boolean)
        {
            Caption = 'Leave Day"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60004; "Employee Posting Group"; Code[10])
        {
            caption = 'Employee Posting Group';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60005; ShortTime; Decimal)
        {
            Caption = 'ShortTime';
            DataClassification = CustomerContent;
            DecimalPlaces = 3 : 3;
            Description = 'CS Field Added 26052019';
        }
        field(60006; "Late Comment"; Text[30])
        {
            Caption = 'Late Comment"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60007; "Late Comment2"; Text[30])
        {
            Caption = 'Late Comment2';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60013; weekly; Integer)
        {
            Caption = 'weekly';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60014; "Attendance Marked"; Boolean)
        {
            Caption = 'Attendance Marked';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60015; "Shift Code"; Code[10])
        {
            Caption = 'Shift Code"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60016; "Applied Leave"; Boolean)
        {
            Caption = 'Applied Leave';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60017; "CO Status"; Text[30])
        {
            Caption = 'CO Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60018; "CO Remarks"; Text[250])
        {
            Caption = 'CO Remarks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60019; CO; Boolean)
        {
            Caption = 'CO';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60025; "Half Day Leave Type"; Option)
        {
            Caption = 'Half Day Leave Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
            OptionCaption = ' ,I Half,II Half';
            OptionMembers = " ","I Half","II Half";
        }
        field(60026; OD; Boolean)
        {
            Caption = 'OD';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
        field(60027; "OD Remarks"; Text[100])
        {
            Caption = 'OD Remark';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26052019';
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }
}

