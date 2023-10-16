table 50491 "Advising Request"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Advising Request List";
    // LookupPageId = "Advising Request List";

    fields
    {
        field(1; "Request No"; Code[20])
        {
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     if Rec."Request No" <> xRec."Request No" then begin
            //         EduSetup.Get();
            //         EduSetup.TestField("Request No.");
            //         NoSeriesMngt.TestManual(GetNoSeriesCode());
            //         "No. Series" := '';
            //     end;
            // end;
        }
        field(2; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnLookup()
            var
                StudentMaster: Record "Student Master-CS";
                FilterString: Text;
            begin
                clear(FilterString);
                if "Department Type" = "Department Type"::"EED Pre-Clinical" then
                    FilterString := 'MED1|MED2|MED3|MED4|BSIC' else
                    if "Department Type" = "Department Type"::"EED Clinical" then
                        FilterString := 'CLN5|CLN6|CLN7|CLN8';
                StudentMaster.Reset();
                StudentMaster.SetFilter(Semester, FilterString);
                if StudentMaster.FindSet() then;
                if Page.RunModal(Page::"Student Details-CS", StudentMaster) = Action::LookupOK then begin
                    Validate("Student No.", StudentMaster."No.");
                end;
            end;

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                FilterString: Text;
                WrongStudentLbl: Label 'You have selected Wrong student.';
            begin
                clear(FilterString);
                if "Department Type" = "Department Type"::"EED Pre-Clinical" then
                    FilterString := 'MED1|MED2|MED3|MED4|BSIC' else
                    if "Department Type" = "Department Type"::"EED Clinical" then
                        FilterString := 'CLN5|CLN6|CLN7|CLN8';
                StudentMaster.Reset();
                StudentMaster.SetFilter(Semester, FilterString);
                if Not StudentMaster.FindSet() then
                    Error(WrongStudentLbl);
                StudentNoValidate();
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(7; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(8; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(9; "Advisor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Department Type" = filter("EED Pre-Clinical")) "Reason wise Advisor Setup"."Advisor Id" where(code = field("Reason Program Code"))
            else
            Employee where(Department = field("Department Type"), "Azure Service Link" = Filter(<> ''));
            // TableRelation = Employee where(Department = field("Department Type"));

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                Clear("Advisor First Name");
                Clear("Advisor Last Name");
                if employee.get("Advisor ID") then begin
                    Validate("Advisor First Name", Employee."First Name");
                    Validate("Advisor Last Name", Employee."Last Name");
                end
                else begin
                    "Advisor First Name" := '';
                    "Advisor Last Name" := '';
                end;
            end;
        }
        field(10; "Global Dimension 1 Code"; code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(11; "Reason Program Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Department Type" = const("EED Pre-Clinical")) "Reason Program" where("Department Type" = field("Department Type"), Semester = field(Semester), "Azure Service Link" = filter(<> ''))
            else
            "Reason Program" where("Department Type" = field("Department Type"));
            Caption = 'Reason Program';

            trigger OnValidate()
            Var
                ReasonProgram: Record "Reason Program";
            begin
                "Reason Description" := '';
                IF ReasonProgram.GET("Reason Program Code") THEN
                    "Reason Description" := ReasonProgram.Description;

                DocApprover.Reset();
                DocApprover.SetRange("User ID", UserId());
                DocApprover.SetRange("Department Approver Type", DocApprover."Department Approver Type"::"EED Pre-Clinical");
                if DocApprover.FindFirst() then begin
                    clear("Advisor ID");
                    clear("Advisor First Name");
                    Clear("Advisor Last Name");
                end;
            end;
        }
        field(12; "Reason Description"; Text[2048])
        {
            DataClassification = CustomerContent;
        }

        field(13; "Advising Topic Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Advising Topics".Code where("Department Type" = field("Department Type"));
            caption = 'Advising Topic';
            trigger OnValidate()
            begin
                AdvisingTopicValidate();
            end;
        }
        field(14; "Advising Topic Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Meeting Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            var
                daterec: Record Date;
                DateMonth: Integer;
            begin
                Validate("Meeting Date text", Format("Meeting Date"));
                Validate("Meeting year", Format(Date2DMY("Meeting Date", 3)));
                DateMonth := Date2DMY("Meeting Date", 2);
                daterec.Reset();
                daterec.SetRange("Period Type", daterec."Period Type"::Month);
                daterec.setrange("Period No.", DateMonth);
                if daterec.FindFirst() then
                    Validate("Meeting Month", daterec."Period Name");
            end;
        }
        field(16; "Meeting Start Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(17; "Meeting End Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(18; "Requested Meeting Date1"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(19; "Requested Meeting Start Time1"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(20; "Requested Meeting End Time 1"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(21; "Requested Meeting Date2"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(22; "Requested Meeting Start Time2"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(23; "Requested Meeting End Time 2"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(24; "Requested Meeting Date3"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(25; "Requested Meeting Start Time3"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(26; "Requested Meeting End Time 3"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(27; "Meeting Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Online,Email,"In-Person","Telephone";
            trigger OnValidate()
            begin
                if "Meeting Mode" = "Meeting Mode"::" " then begin
                    "Confirm Date" := "Confirm Date"::" ";
                    Clear("Meeting Date");
                    Clear("Meeting Start Time 1");
                    Clear("Meeting End Time 1");
                end;
            end;
        }
        field(28; "Request Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Approved,Rejected,Completed,Rescheduled,Cancel;
            OptionCaption = ' ,Pending,Approved,Rejected,Completed,Rescheduled,Cancelled';
        }
        field(29; "Rejected Reason"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" where(Type = filter('EED'));

            trigger OnValidate()
            var
                Reasoncode: record "Reason Code";
            begin
                Clear("Rejection reason description");
                if Reasoncode.Get("Rejected Reason") then
                    Validate("Rejection Reason Description", Reasoncode.Description);
            end;
        }
        field(30; "Problem Solution Id"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Problem Solution";
            Description = 'Not in used';
            Caption = 'Problem';
            ObsoleteState = Pending;
            trigger OnValidate()
            var
                ProblemSolution: Record "Problem Solution";
            begin
                "Problem solution description" := '';
                if ProblemSolution.get("Problem Solution Id") then
                    "Problem solution description" := ProblemSolution.Solution;
            end;

        }
        field(31; "Previous Advising Request No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Advising Request";
            Editable = false;
        }

        field(32; "Next Advising Request No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Advising Request";
            Editable = false;
        }
        field(33; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(35; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(36; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(37; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(38; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(39; "Requestor"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "By Student","By Faculty";
        }
        field(40; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "First Character"; code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Confirm Date"; Option)
        {
            Caption = 'Confirm Date';
            OptionMembers = " ","Date 1","Date 2","Date 3";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                confirmdateValidation();
            end;
        }
        field(43; "Enrollment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Entry From Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Rescheduled Old Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(46; "Problem solution description"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Solution';

            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
            begin
                IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange(Problem, Rec."Problem Solution Id 1");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        // if page.runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN
                            "Problem solution description" := ProblemSolution.Solution;
                end;
            end;

        }

        field(47; "Meeting Start Time 1"; Time)
        {
            Caption = 'Meeting Start Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(48; "Meeting End Time 1"; Time)
        {
            caption = 'Meeting End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(49; "Requested Meeting Start Time 1"; Time)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(50; "Requested Meeting End Time1"; Time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(51; "Requested Meeting Start Time 2"; Time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(52; "Requested Meeting End Time2"; Time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }

        field(53; "Requested Meeting Start Time 3"; time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(54; "Requested Meeting End Time3"; Time)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                Clear("Meeting Date");
                Clear("Meeting Start Time 1");
                Clear("Meeting End Time 1");
                "Confirm Date" := "Confirm Date"::" ";
            end;
        }
        field(55; "Problem Solution Id 1"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Problem';
            TableRelation = "Problem Solution".Problem where("Department Type" = field("Department Type"));
            //TableRelation = "Problem Solution";
            // trigger OnValidate()
            // var
            //     ProblemSolution: Record "Problem Solution";
            // begin
            //     "Problem solution description" := '';
            //     ProblemSolution.reset();
            //     ProblemSolution.SetRange(problem, "Problem Solution Id");
            //     if ProblemSolution.FindFirst() then begin
            //         "Problem solution description" := ProblemSolution.Solution;
            //         "Problem Solution Id" := ProblemSolution.Problem;
            //     end;
            // end;

            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
                PrevProblem: Text[100];
            // VarPage: Page "Problem Solution List";
            begin
                IF "Department Type" <> "Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetRange("Department Type", "Department Type");
                    if ProblemSolution.FindSet() then;
                    // if page.runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN begin
                    "Problem solution description" := '';
                    "Problem solution description" := ProblemSolution.Solution;
                    "Problem Solution Id 1" := ProblemSolution.Problem;
                    // end;
                end else begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        repeat
                            IF PrevProblem <> ProblemSolution.Problem then begin
                                PrevProblem := ProblemSolution.Problem;
                                ProblemSolution.Mark(true);
                            end;
                        until ProblemSolution.Next() = 0;
                    IF ProblemSolution.MarkedOnly(true) then begin
                        // VarPage.SetRecord(ProblemSolution);
                        // VarPage.SetSelectionFilter(ProblemSolution);
                        // VarPage.InitParameter(true);
                        // VarPage.LookupMode(true);
                        // if VarPage.RunModal() = ACTION::LookupOK THEN
                        //     "Problem Solution Id 1" := ProblemSolution.Problem;
                        // If page.Runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN begin
                        "Problem Solution Id 1" := ProblemSolution.Problem;
                        // end;
                    end;
                end;
            end;



        }
        field(56; "Time Zone"; Option)
        {
            OptionCaption = 'Indian Standard Time,Pacific Standard Time';
            OptionMembers = "Indian Standard Time","Pacific Standard Time";

        }
        Field(57; Location; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(58; "Core Topic"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(59; "Request to Chair"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Student Email"; text[50])
        {
            Caption = 'Student Email';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(61; "First Name"; text[35])
        {
            Caption = 'First Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(62; "Last Name"; text[35])
        {
            Caption = 'Last Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(63; "Rejection Reason Description"; text[100])
        {
            Caption = 'Rejection Reason Description';
            DataClassification = ToBeClassified;
        }
        field(64; "Department Type"; Option)
        {
            Caption = 'Department Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Store';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Student Services","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Store;
            trigger OnValidate()
            var
                WrongDepartmentLbl: Label 'You have selected wrong Department.';
            begin
                if ("Department Type" = "Department Type"::"EED Clinical") or ("Department Type" = "Department Type"::"EED Pre-Clinical") then begin
                end else
                    Error(WrongDepartmentLbl)
            end;
        }
        field(65; "Advisor First Name"; text[80])
        {
            Caption = 'Advisor First Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Advisor Last Name"; text[80])
        {
            Caption = 'Advisor Last Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67; "Rescheduled New Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68; "Meeting Date text"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Meeting Month"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Meeting year"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Advising Flag"; Boolean)
        {
            Caption = 'Advising Requst Mail Sent';
            Editable = false;
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = exist (LookUpTable where (FieldToBeFiltered = const (Filter)));
        }
        field(73; "Problem Solution Id 2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Problem 2';
            TableRelation = "Problem Solution".Problem where("Department Type" = field("Department Type"));
            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
                PrevProblem: Text[100];
            // VarPage: Page "Problem Solution List";
            begin
                IF "Department Type" = "Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        repeat
                            IF PrevProblem <> ProblemSolution.Problem then begin
                                PrevProblem := ProblemSolution.Problem;
                                ProblemSolution.Mark(true);
                            end;
                        until ProblemSolution.Next() = 0;
                    IF ProblemSolution.MarkedOnly(true) then begin
                        // If page.Runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN begin
                        "Problem Solution Id 2" := ProblemSolution.Problem;
                        // end;
                    end;
                end;
            end;


        }
        field(74; "Problem solution description 2"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Solution 2';
            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
            begin
                IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange(Problem, Rec."Problem Solution Id 2");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        // if page.runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN
                            "Problem solution description 2" := ProblemSolution.Solution;
                end;
            end;
        }
        field(75; "Problem Solution Id 3"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Problem 3';
            TableRelation = "Problem Solution".Problem where("Department Type" = field("Department Type"));
            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
                PrevProblem: Text[100];
            // VarPage: Page "Problem Solution List";
            begin
                IF "Department Type" = "Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        repeat
                            IF PrevProblem <> ProblemSolution.Problem then begin
                                PrevProblem := ProblemSolution.Problem;
                                ProblemSolution.Mark(true);
                            end;
                        until ProblemSolution.Next() = 0;
                    IF ProblemSolution.MarkedOnly(true) then begin
                        // If page.Runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN begin
                        //     "Problem Solution Id 3" := ProblemSolution.Problem;
                        // end;
                    end;
                end;
            end;


        }
        field(76; "Problem solution description 3"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Solution 3';
            trigger OnLookup()
            var
                ProblemSolution: Record "Problem Solution";
            begin
                IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
                    ProblemSolution.Reset();
                    ProblemSolution.SetCurrentKey(Problem, "Department Type");
                    ProblemSolution.SetRange(Problem, Rec."Problem Solution Id 3");
                    ProblemSolution.SetRange("Department Type", ProblemSolution."Department Type"::"EED Pre-Clinical");
                    ProblemSolution.SetAscending(Problem, true);
                    if ProblemSolution.FindSet() then
                        // if page.runmodal(Page::"Problem Solution List", ProblemSolution) = ACTION::LookupOK THEN
                            "Problem solution description 3" := ProblemSolution.Solution;
                end;
            end;
        }
        field(77; Comment; Text[1000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78; "Student Status"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field("Student No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Request No")
        {
            Clustered = true;
        }
        key(Key2; "Request Date")
        {

        }
    }

    trigger OnInsert()
    var
        DeprtValidationLbl: Label 'Department should be Basic Science Or Clinical.';
    begin
        //code for request no. No series +
        usersetup.get(UserId());
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", '9000');
        if EduSetup.FindFirst() then begin
            EduSetup.TESTFIELD("Request No.");
            NoSeriesMngt.InitSeries(EduSetup."Request No.", xRec."No. Series", 0D, "Request No", Rec."No. Series");
            // end Else begin
            //     EduSetup.Reset();
            //     EduSetup.SetFilter("Request No.", '<>%1', '');
            //     if EduSetup.FindFirst() then begin
            //         NoSeriesMngt.InitSeries(EduSetup."Request No.", xRec."No. Series", 0D, "Request No", Rec."No. Series");
            //     end;
        end;
        //code for request no. No series -
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
        //Validate("Request Status", "Request Status"::Pending);
        Inserted := true;
        //Rec."Next Advising Request No" := NoSeriesMngt.GetNextNo(EduSetup."Request No.", WorkDate(), true);
        // if "Entry From Portal" = true then
        //     Requestor := Requestor::"By Student"
        // Else
        //     Requestor := Requestor::"By Faculty";

        IF not "Entry From Portal" then begin
            if ChecDocumentAppDepartment() = 0 then // Pleaase check this code, unable to run from API
                Error(DeprtValidationLbl);
            "Request Status" := "Request Status"::Pending;
        end;

        "Advising Flag" := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        If xRec.Updated = Updated then
            Updated := true;

        Clear(NextNum);
        if Rec."Student No." <> '' then begin
            AdvisingRequestRec.Reset();
            AdvisingRequestRec.SetFilter("Request Status", '%1|%2', AdvisingRequestRec."Request Status"::Pending, AdvisingRequestRec."Request Status"::" ");
            AdvisingRequestRec.SetRange("Student No.", Rec."Student No.");
            if AdvisingRequestRec.FindLast() then begin
                NextNum := AdvisingRequestRec."Request No";
                Rec.Validate("Previous Advising Request No", NextNum);
            end else
                Rec.Validate("Previous Advising Request No", '');
        end;
    end;

    trigger OnDelete()
    var
    begin
        Error('You can not delete application');
    end;

    var
        DocumentApprover: Record "Document Approver Users";
        DocApprover: Record "Document Approver Users";
        NextNum: Code[20];
        AdvisingRequestRec: Record "Advising Request";
        LastName: Text[35];
        CopyString: Text;
        usersetup: Record "User Setup";
        SelectNoSeriesAllow: Boolean;
        EduSetup: Record "Education Setup-CS";
        NoSeriesRec: Record "No. Series";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        DimMngt: Codeunit DimensionManagement;

    /*procedure ChecDocumentAppDepartment(): Integer
    begin
        if DepartmentIsBasicScience() and not DeprtMentIsCleanincal() then begin
            Validate("Department Type", Rec."Department Type"::"EED Pre-Clinical");
            exit(1);
        end else
            if not DepartmentIsBasicScience() and DeprtMentIsCleanincal() then begin
                Validate("Department Type", Rec."Department Type"::"EED Clinical");
                exit(2)
            end;
        if DepartmentIsBasicScience() and DeprtMentIsCleanincal() then begin
            Validate("Department Type", Rec."Department Type"::"EED Pre-Clinical");
            exit(3)
        end;
        exit(0);
    end;

    procedure DepartmentIsBasicScience(): Boolean
    var
        DocApprovaluser: Record "Document Approver Users";
    begin
        DocApprovaluser.Reset();
        DocApprovaluser.SetRange("User ID", UserId);
        if DocApprovaluser.FindSet() then
            repeat
                if DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Pre-Clinical" then
                    exit(true);
            until DocApprovaluser.Next() = 0;
        exit(false);
    end;

    procedure DeprtMentIsCleanincal(): Boolean
    var
        DocApprovaluser: Record "Document Approver Users";
    begin
        DocApprovaluser.Reset();
        DocApprovaluser.SetRange("User ID", UserId);
        if DocApprovaluser.FindSet() then
            repeat
                if DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Clinical" then
                    exit(true);
            until DocApprovaluser.Next() = 0;
        exit(false);
    end;*/
    procedure ChecDocumentAppDepartment(): Integer
    begin
        if DepartmentIsBasicScience() and not DeprtMentIsCleanincal() then begin
            Validate("Department Type", Rec."Department Type"::"EED Pre-Clinical");
            exit(1);
        end else
            if not DepartmentIsBasicScience() and DeprtMentIsCleanincal() then begin
                Validate("Department Type", Rec."Department Type"::"EED Clinical");
                exit(2);
            end;
        if DepartmentIsBasicScience() and DeprtMentIsCleanincal() then begin
            Validate("Department Type", Rec."Department Type"::"EED Pre-Clinical");
            exit(3)
        end;
        if DepartmentIsBasicScience() and DeprtMentIsCleanincal() and DepartmentIsBlank() then begin
            Validate("Department Type", Rec."Department Type"::"EED Pre-Clinical");
            exit(4);
        end;
        exit(0);
    end;

    procedure DepartmentIsBasicScience(): Boolean
    var
        DocApprovaluser: Record "Document Approver Users";
    begin
        DocApprovaluser.Reset();
        DocApprovaluser.SetRange("User ID", UserId);
        if DocApprovaluser.FindSet() then
            repeat
                if DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Pre-Clinical" then
                    exit(true);
            until DocApprovaluser.Next() = 0;
        exit(false);
    end;

    procedure DeprtMentIsCleanincal(): Boolean
    var
        DocApprovaluser: Record "Document Approver Users";
    begin
        DocApprovaluser.Reset();
        DocApprovaluser.SetRange("User ID", UserId);
        if DocApprovaluser.FindSet() then
            repeat
                if DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Clinical" then
                    exit(true);
            until DocApprovaluser.Next() = 0;
        exit(false);
    end;

    procedure DepartmentIsBlank(): Boolean
    var
        DocApprovaluser: Record "Document Approver Users";
    begin
        DocApprovaluser.Reset();
        DocApprovaluser.SetRange("User ID", UserId);
        if DocApprovaluser.FindSet() then
            repeat
                // if (DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Clinical") and
                //  (DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::"EED Pre-Clinical") and
                if (DocApprovaluser."Department Approver Type" = DocApprovaluser."Department Approver Type"::" ") then
                    exit(true);
            until DocApprovaluser.Next() = 0;
        exit(false);
    end;

    //code for request no - No series +
    procedure AssistEdit("Advising Req": Record "Advising Request"): Boolean
    var
        Rec_AdvisingReq: Record "Advising Request";
        NoSerMgnt: Codeunit NoSeriesManagement;
    begin
        with Rec_AdvisingReq do begin
            Copy(Rec);
            usersetup.Get(UserId());
            EduSetup.Reset();
            EduSetup.SetRange("Global Dimension 1 Code", '9000');
            if EduSetup.FindFirst() then begin
                EduSetup.TestField("Request No.");
                if NoSerMgnt.SelectSeries(EduSetup."Request No.", "Advising Req"."No. Series", "No. Series") then begin
                    NoSerMgnt.SetSeries("Request No");
                    Rec := Rec_AdvisingReq;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure TestNumSer()
    var
        Check: Boolean;
    begin
        EduSetup.Get();
        Check := false;
        if not Check then
            EduSetup.TestField("Request No.");
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        Check: Boolean;
        NoSeriesCode: Code[20];
    begin
        EduSetup.Get();
        Check := false;
        if Check then
            exit;
        NoSeriesCode := EduSetup."Request No.";
        exit(NoSeriesMngt.GetNoSeriesWithCheck(NoSeriesCode, selectNoSeriesAllow, "No. Series"))
    end;

    procedure InitInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            if "Request No" = '' then begin
                TestNumSer();
                NoSeriesMngt.InitSeries(GetNoSeriesCode(), xRec."No. Series", Today, "Request No", "No. Series");
            end;
        initRecord();
    end;

    procedure InitRecord()
    var
        IsHandled: Boolean;
    begin
        EduSetup.Get();
        IsHandled := false;
        if not IsHandled then
            NoSeriesMngt.SetDefaultSeries("No. Series", EduSetup."Request No.");
    end;
    //code for request no - No series -
    procedure StudentNoValidate()
    var
        StudentMasterCS: Record "Student Master-CS";
        NextNo: Code[20];
        AdvisingRequestRec: Record "Advising Request";
    begin
        IF StudentMasterCS.GET("Student No.") THEN begin
            Validate("Student Name", StudentMasterCS."Student Name");
            Validate("Academic Year", StudentMasterCS."Academic Year");
            Validate(Semester, StudentMasterCS.Semester);
            Validate(term, StudentMasterCS.term);
            Validate("Course Code", StudentMasterCS."Course Code");
            Validate("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
            Validate("Enrollment No.", StudentMasterCS."Enrollment No.");
            LastName := StudentMasterCS."Last Name";
            CopyString := CopyStr(lastname, 1, 1);
            Validate("First Character", CopyString);
            Validate("Advising Topic Code", '');
            Validate("Advising Topic Description", '');
            Validate("Advisor ID", '');
            Validate("Student Email", StudentMasterCS."E-Mail Address");
            Validate("First Name", StudentMasterCS."First Name");
            Validate("Last Name", StudentMasterCS."Last Name");
        end;
        Clear(NextNo);
        if Rec."Student No." <> '' then begin
            AdvisingRequestRec.Reset();
            AdvisingRequestRec.SetFilter("Request Status", '%1|%2', AdvisingRequestRec."Request Status"::Pending, AdvisingRequestRec."Request Status"::" ");
            AdvisingRequestRec.SetRange("Student No.", Rec."Student No.");
            if AdvisingRequestRec.FindLast() then begin
                NextNo := AdvisingRequestRec."Request No";
                Rec.Validate("Previous Advising Request No", NextNo);
            end else
                Rec.Validate("Previous Advising Request No", '');
        end Else begin
            "Student Name" := '';
            "Academic Year" := '';
            Semester := '';
            Term := Term::FALL;
            "Course Code" := '';
            "Global Dimension 1 Code" := '';
            "Enrollment No." := '';
            LastName := '';

            "First Character" := '';
            "Advising Topic Code" := '';
            Validate("Advising Topic Description", '');
            Validate("Advisor ID", '');
            "Student Email" := '';
            "First Name" := '';
            "Last Name" := '';
        end;
    end;

    procedure AdvisingTopicValidate()
    var
        TopicSetup: Record "Topic Master";
        AdvisingTopic: Record "Advising Topics";
        FirstChar: Text;
        LastChar: Text;
        SetupError: TextConst ENU = 'Setup not found for this topic code';
    begin
        if "Advising Topic Code" = '' then begin
            "Advising Topic Description" := '';
            "Advisor ID" := '';
        end;
        //In case of Advising topic code not blank
        if "Advising Topic Code" <> '' then begin
            if AdvisingTopic.Get("Advising Topic Code") then
                Validate("Advising Topic Description", AdvisingTopic.Description)
            else
                "Advising Topic Code" := '';

            // if DepartmentIsBasicScience() = false then begin
            //     TopicSetup.Reset();
            //     TopicSetup.SetRange(Code, Rec."Advising Topic Code");
            //     if TopicSetup.FindSet() then
            //         repeat
            //             Clear(FirstChar);
            //             Clear(LastChar);
            //             FirstChar := CopyStr(TopicSetup."Student Last Name Char.", 1, 1);
            //             LastChar := CopyStr(TopicSetup."Student Last Name Char.", 3, 1);
            //             if "First Character" in [FirstChar .. LastChar] then
            //                 Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
            //         until TopicSetup.Next() = 0;
            //     // end else
            //     //     Error(SetupError);
            // end;
        end;
    end;
    // procedure AdvisingTopicValidate()
    // var
    //     TopicSetup: Record "Topic Master";
    //     AdvisingTopic: Record "Advising Topics";
    //     tempbool: Boolean;
    //     FirstChar: code[1];
    //     SetupError: TextConst ENU = 'Setup not found for this topic code';
    //     temp: Text;
    // begin
    //     if "Advising Topic Code" = '' then begin
    //         "Advising Topic Description" := '';
    //         "Advisor ID" := '';
    //     end;
    //     if "Advising Topic Code" <> '' then begin
    //         if AdvisingTopic.Get("Advising Topic Code") then
    //             Validate("Advising Topic Description", AdvisingTopic.Description)
    //         else
    //             "Advising Topic Code" := '';

    //         TopicSetup.Reset();
    //         TopicSetup.SetRange(Code, Rec."Advising Topic Code");
    //         if TopicSetup.FindSet() then begin
    //             repeat
    //                 if Rec."First Character" <> '' then begin
    //                     // if Rec."First Character" = 'A' then
    //                     if TopicSetup.a = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'B' then
    //                     if TopicSetup.b = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'C' then
    //                     if TopicSetup.C = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'D' then
    //                     if TopicSetup.D = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'E' then
    //                     if TopicSetup.E = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'F' then
    //                     if TopicSetup.F = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'G' then
    //                     if TopicSetup.G = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'H' then
    //                     if TopicSetup.H = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'I' then
    //                     if TopicSetup.i = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'J' then
    //                     if TopicSetup.j = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'K' then
    //                     if TopicSetup.k = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'L' then
    //                     if TopicSetup.l = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'M' then
    //                     if TopicSetup.m = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'N' then
    //                     if TopicSetup.n = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'O' then
    //                     if TopicSetup.o = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'P' then
    //                     if TopicSetup.p = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'Q' then
    //                     if TopicSetup.q = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'R' then
    //                     if TopicSetup.r = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'S' then
    //                     if TopicSetup.s = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'T' then
    //                     if TopicSetup.t = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'U' then
    //                     if TopicSetup.u = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'V' then
    //                     if TopicSetup.v = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'W' then
    //                     if TopicSetup.w = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'X' then
    //                     if TopicSetup.X = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'Y' then
    //                     if TopicSetup.Y = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                     // if Rec."First Character" = 'Z' then
    //                     if TopicSetup.Z = true then
    //                         Rec.Validate("Advisor ID", TopicSetup."Adviser Id");
    //                 end;
    //             until TopicSetup.Next() = 0;
    //             // Message('%1', Rec."First Character");
    //         end
    //         else
    //             Error(SetupError);
    //     end;
    // end;

    procedure confirmdateValidation()
    // Var
    //     Dates: Record Date;
    // begin
    //     Clear("Meeting Date");
    //     Clear("Meeting Start Time 1");
    //     Clear("Meeting End Time 1");
    Var
        ConfirmDateError: Label 'Please select the Confirm Date option!';
        Dates: Record Date;
    begin
        Clear("Meeting Date");
        Clear("Meeting Start Time 1");
        Clear("Meeting End Time 1");

        if "Confirm Date" = "Confirm Date"::" " then
            Error(ConfirmDateError);

        if "Confirm Date" = "Confirm Date"::"Date 1" then begin
            TestField("Meeting Mode");
            // if "Meeting Mode" <> "Meeting Mode"::" " then begin
            TestField("Requested Meeting Date1");
            TestField("Requested Meeting Start Time 1");
            TestField("Requested Meeting End Time1");
            Validate("Meeting Date", "Requested Meeting Date1");
            Validate("Meeting Start Time 1", "Requested Meeting Start Time 1");
            Validate("Meeting End Time 1", "Requested Meeting End Time1");
            // end else
            // Error('Meeting mode must have a value in it.');
        end;
        if "Confirm Date" = "Confirm Date"::"Date 2" then begin
            TestField("Meeting Mode");
            TestField("Requested Meeting Date2");
            TestField("Requested Meeting Start Time 2");
            TestField("Requested Meeting End Time2");
            Validate("Meeting Date", "Requested Meeting Date2");
            Validate("Meeting Start Time 1", "Requested Meeting Start Time 2");
            Validate("Meeting End Time 1", "Requested Meeting End Time2");
        end;
        if "Confirm Date" = "Confirm Date"::"Date 3" then begin
            TestField("Meeting Mode");
            TestField("Requested Meeting Date3");
            TestField("Requested Meeting Start Time 3");
            TestField("Requested Meeting End Time3");
            Validate("Meeting Date", "Requested Meeting Date3");
            Validate("Meeting Start Time 1", "Requested Meeting Start Time 3");
            Validate("Meeting End Time 1", "Requested Meeting End Time3");
        end;
        WITH Dates DO BEGIN
            GET("Period Type"::Date, "Meeting Date");
            if Dates."Period Name" = 'Sunday' then begin
                if "Meeting Start Time 1" >= 150001T then
                    Error('Start Time is not Valid for Sunday');

                if "Meeting End Time 1" >= 150001T then
                    Error('End Time is not Valid for Sunday');
            end;
        end;
    end;

    procedure TestFields()
    begin
        // If not "Entry From Portal" then
        //     TestField("Confirm Date");
        If "Department Type" = "Department Type"::"EED Clinical" then
            TestField("Advising Topic Code");
        TestField("Student No.");
        TestField("Advisor ID");
        TestField("Request No");
        TestField("Request Date");
        TestField("Student No.");
        TestField("Student Name");
        TestField("Academic Year");
        TestField(Semester);
        TestField("Course Code");
        TestField("Global Dimension 1 Code");
        IF "Department Type" <> "Department Type"::"EED Clinical" then begin
            TestField("Reason Program Code");
            TestField("Reason Description");
        end;
        TestField("Meeting Date");
        TestField("Meeting Start Time 1");
        TestField("Meeting End Time 1");

        // TestField("Meeting Mode");Removed due to requirement
        //TestField("Problem solution description");  Removed due to requirement
        // TestField("Problem Solution Id");Removed due to requirement
    End;

    // procedure AdvisingReScheduleMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    // begin
    //     BodyText := '';
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     // DocApprover.Reset();
    //     // DocApprover.SetRange("User ID", UserId());
    //     // DocApprover.SetFilter("Department Approver Type", '<>%1', DocApprover."Department Approver Type"::"EED Pre-Clinical");
    //     // DocApprover.SetFilter("Department Approver Type", '%1&%2|%3', DocApprover."Department Approver Type"::"EED Clinical", DocApprover."Department Approver Type"::"EED Pre-Clinical", DocApprover."Department Approver Type"::"EED Clinical");
    //     // if DocApprover.FindSet() then begin
    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if Studentmaster.Get("Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 employeeRec2.TestField("Company E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM:' + "Request No" + ' Advising Appointment Request – Re-scheduled by Clinical EED Faculty/Clinical Chair';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair has rescheduled the Appointment Request.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             until employeeRec2.Next = 0;
    //     end;

    //     // DocApprover.Reset();
    //     // DocApprover.SetRange("User ID", UserId());
    //     // DocApprover.SetRange("Department Approver Type", DocApprover."Department Approver Type"::"EED Pre-Clinical");
    //     // if DocApprover.Findfirst() then begin
    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Pre-Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if Studentmaster.Get("Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 employeeRec2.TestField("Company E-Mail");
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := "Request No" + ':Advising Appointment – Meeting Update';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('The following student has been rescheduled for the follow-up appointment:');
    //                 // SmtpMail.AppendtoBody('The following student has completed their current Advising Appointment with ' + "Advisor First Name" + ' ' + "Advisor Last Name" + ' and has been scheduled for the follow-up appointment:');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Student Name ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + '</li>');
    //                 // SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Follow-up date: ' + Format("Meeting Date") + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Follow-up time: ' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor Topic: ' + "Advising Topic Description" + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<li> Advisor: ' + "Advisor First Name" + ' ' + "Advisor Last Name" + '</li>');
    //                 // smtpmail.AppendtoBody('The SLcM System has added this appointment to the student’s Advising History.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             Until employeeRec2.Next = 0;
    //     end;
    // end;

    procedure Reschedule()
    var
        employeeRec: Record Employee;
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        WebserviceFn: Codeunit WebServicesFunctionsCSL;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[200];
        Recipients: List of [Text];
        Recipient: Text[100];
        RequestNo: Code[20];
        AdvReq: Record "Advising Request";
        AdvisingRequest: record "Advising Request";
        EmailAddress: TEXT[100];
        EmailSetup: Record "EMail Setup";
    //ConfirmLbl: Label 'New Advising Request Created,Rescheduled Request no. %1, Do you want to open Advising Request.';
    begin
        SmtpMailRec.Get();
        TestFields();
        // Informations();
        //For Rescheduled Request no. +
        usersetup.get(UserId());
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", '9000');
        if EduSetup.FindFirst() then begin
            EduSetup.TESTFIELD("Request No.");
            RequestNo := NoSeriesMngt.GetNextNo(EduSetup."Request No.", WorkDate(), true);
        end;

        AdvReq.Init();
        AdvReq."Request No" := RequestNo;
        AdvReq."Request Date" := Rec."Request Date";
        AdvReq."Student No." := Rec."Student No.";
        AdvReq."Student Name" := rec."Student Name";
        AdvReq."Enrollment No." := rec."Enrollment No.";
        AdvReq."Advising Topic Code" := Rec."Advising Topic Code";
        AdvReq."Advising Topic Description" := rec."Advising Topic Description";
        AdvReq."Academic Year" := rec."Academic Year";
        AdvReq.Semester := rec.Semester;
        AdvReq.Term := Rec.Term;
        AdvReq."Course Code" := Rec."Course Code";
        AdvReq."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
        AdvReq."Advisor ID" := Rec."Advisor ID";
        AdvReq."Reason Program Code" := Rec."Reason Program Code";
        AdvReq."Reason Description" := Rec."Reason Description";
        AdvReq."Meeting Date" := Rec."Meeting Date";
        AdvReq."Meeting Start Time 1" := rec."Meeting Start Time 1";
        AdvReq."Meeting End Time 1" := Rec."Meeting End Time 1";
        AdvReq."Requested Meeting Date1" := Rec."Requested Meeting Date1";
        AdvReq."Requested Meeting Date2" := Rec."Requested Meeting Date2";
        AdvReq."Requested Meeting Date3" := Rec."Requested Meeting Date3";
        AdvReq."Requested Meeting Start Time 1" := Rec."Requested Meeting Start Time 1";
        AdvReq."Requested Meeting Start Time 2" := Rec."Requested Meeting Start Time 2";
        AdvReq."Requested Meeting Start Time 3" := Rec."Requested Meeting Start Time 3";
        AdvReq."Requested Meeting end Time1" := Rec."Requested Meeting end Time1";
        AdvReq."Requested Meeting end Time2" := Rec."Requested Meeting end Time2";
        AdvReq."Requested Meeting end Time3" := Rec."Requested Meeting end Time3";
        AdvReq."Confirm Date" := "Confirm Date"::" ";
        AdvReq."Meeting Mode" := Rec."Meeting Mode";
        AdvReq."Request Status" := "Request Status"::Pending;
        AdvReq."Previous Advising Request No" := '';
        AdvReq."Next Advising Request No" := '';
        AdvReq."Rejected Reason" := rec."Rejected Reason";
        AdvReq."Problem Solution Id 1" := '';
        AdvReq."Problem Solution description" := '';
        AdvReq."Created By" := UserId();
        AdvReq."Created On" := WorkDate();
        AdvReq."Modified By" := '';
        AdvReq."Modified On" := 0D;
        AdvReq.Requestor := Rec.Requestor;
        AdvReq."Rescheduled Old Req. No." := Rec."Request No";
        AdvReq."First Name" := Rec."First Name";
        AdvReq."Last Name" := Rec."Last Name";
        AdvReq."Student Email" := Rec."Student Email";
        AdvReq."Rejection Reason Description" := Rec."Rejection Reason Description";
        AdvReq."Department Type" := Rec."Department Type";
        Advreq."Advisor First Name" := Rec."Advisor First Name";
        Advreq."Advisor Last Name" := Rec."Advisor Last Name";
        AdvReq.insert(true);
        //For Rescheduled Request no. -
        // Message('New Advising Request Created,Rescheduled Request no. %1', AdvReq."Request No");

        Rec.Validate("Rescheduled New Req. No.", AdvReq."Request No");
        Rec.Validate("Request Status", "Request Status"::Rescheduled);
        Rec.Modify();

        //FOR MAIL +
        // DocApprover.Reset();
        // DocApprover.SetRange("User ID", UserId());
        // DocApprover.SetFilter("Department Approver Type", '<>%1', DocApprover."Department Approver Type"::"EED Pre-Clinical");
        // DocApprover.SetFilter("Department Approver Type", '%1&%2|%3', DocApprover."Department Approver Type"::"EED Clinical", DocApprover."Department Approver Type"::"EED Pre-Clinical", DocApprover."Department Approver Type"::"EED Clinical");
        // if DocApprover.FindSet() then begin
        //CSPL-00307 20-10-21 Moved Reschedule Mail Code to COnfirm Button 
        /*
        if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
            SmtpMailRec.Get();
            if EduSetup.Get('AUA') then
                EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
            if employeeRec.Get(Rec."Advisor ID") then;
            employeeRec.TESTFIELD(employeeRec."E-Mail");
            if Studentmaster.GET(rec."Student No.") then;
            Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
            Recipient := Studentmaster."E-Mail Address";
            // Recipient := 'Sumit.n@siriusdynamics.com';
            Recipients := Recipient.Split(';');
            SenderName := 'SLcM System Administrator';
            SenderAddress := SmtpMailRec."Email Address";
            Subject := 'SLcM:' + "Request No" + ' Advising Appointment Request – Re-scheduled by Clinical EED Faculty/Clinical Chair';
            SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
            SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair has rescheduled your Appointment Request.');
            SmtpMail.AppendtoBody('<br>');
            SmtpMail.AppendtoBody('<ul><li> Request No.:' + "Request No" + '.' + '</li>');
            SmtpMail.AppendtoBody('<li> Advisor:' + employeeRec."Last Name" + ',Student:' + Studentmaster."First Name" + '</li>');
            SmtpMail.AppendtoBody('<li> AUA Email ID:' + EmailAddress + '</li>');
            SmtpMail.AppendtoBody('<li> Meeting Date and Time:' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + '</li>');
            SmtpMail.AppendtoBody('<li> Meeting Mode:' + Format("Meeting Mode") + '</li></ul>');
            // SmtpMail.AppendtoBody('<li>' + Rec."Reason Program Code" + '</li></ul>');
            SmtpMail.AppendtoBody('<br>');
            SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
            SmtpMail.AppendtoBody('<br><br><br>');
            SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
            SmtpMail.AppendtoBody('<br><br><br>');
            SmtpMail.AppendtoBody('Thanking You,');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('SLcM System Administrator');
            BodyText := SmtpMail.GetBody();
            Mail_lCU.Send();

            // Send mail to admin +
            if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
                AdvisingReScheduleMailToAdmin();
            // Send mail to admin -

            //FOR NOTIFICATION +
            WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
            Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
            Recipient, 1, Studentmaster."Mobile Number", '', 1);
            WebserviceFn.AdvisingRequestAzureMeetingCancellation(Rec);
            //FOR NOTIFICATION -
        end;
        // end;
        //FOR MAIL -

        // DocApprover.Reset();
        // DocApprover.SetRange("User ID", UserId());
        // DocApprover.SetRange("Department Approver Type", DocApprover."Department Approver Type"::"EED Pre-Clinical");
        // if DocApprover.FindFirst() then begin
        if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
            SmtpMailRec.Get();
            if EduSetup.Get('AUA') then
                EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
            if employeeRec.Get(Rec."Advisor ID") then;
            employeeRec.TESTFIELD(employeeRec."E-Mail");
            if Studentmaster.GET(rec."Student No.") then;
            Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
            Recipient := Studentmaster."E-Mail Address";
            // Recipient := 'Sumit.n@siriusdynamics.com';
            Recipients := Recipient.Split(';');
            SenderName := 'SLcM System Administrator';
            SenderAddress := SmtpMailRec."Email Address";
            Subject := "Request No" + ':Advising Appointment – Meeting Update';
            SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
            SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('Thank you for meeting with the ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ' for your Advising Appointment. As per the discussion your next follow-up details are as below:');
            SmtpMail.AppendtoBody('<br>');
            SmtpMail.AppendtoBody('<ul><li> Follow-up date:' + Format("Meeting Date") + '</li>');
            SmtpMail.AppendtoBody('<li> Follow-up time:' + Format("Meeting Mode") + '</li>');
            SmtpMail.AppendtoBody('<li> Advising Topic:' + "Advising Topic Description" + '</li>');
            SmtpMail.AppendtoBody('<li> Advisor:' + "Advisor First Name" + "Advisor Last Name" + '</li></ul>');
            SmtpMail.AppendtoBody('The SLcM System has added this appointment to your account’s Advising History.');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('We would like to request you to kindly click on the below link and complete the survey related to the meeting conducted.');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('https://www.surveymonkey.com/r/R82MQHX');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
            SmtpMail.AppendtoBody('<br><br><br>');
            SmtpMail.AppendtoBody('Thanking You,');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('SLcM System Administrator');
            SmtpMail.AppendtoBody('<br><br>');
            SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
            BodyText := SmtpMail.GetBody();
            Mail_lCU.Send();

            // Send mail to admin +
            AdvisingReScheduleMailToAdmin();
            // Send mail to admin -

            //FOR NOTIFICATION +
            WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
            Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
            Recipient, 1, Studentmaster."Mobile Number", '', 1);
            WebserviceFn.AdvisingRequestAzureMeetingCancellation(Rec);
            //FOR NOTIFICATION -
        end;
        *///CSPL-00307 20-10-21 Moved Reschedule Mail Code to COnfirm Button 


        //if confirm('New Advising Request Created. Request No ' + AdvReq."Request No" + ' has been Rescheduled. Do you want to open Advising Request?') then
        // IF Confirm('New Advising Request Created. Request No. (' + Rec."Request No" + ') has been Rescheduled to (' + AdvReq."Request No" + '). Do you want to open the rescheduled Advising Request?') then
        //     page.Run(page::"Advising Request Card", AdvReq);

        // Commit();
        // AdvisingRequest.reset();
        // if AdvisingRequest.findset() then;
        // Page.RunModal(Page::"App. Resch. Advs. Request List", AdvisingRequest);
    end;

    // procedure Completed()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     AdvisingReq: Record "Advising Request";
    //     AdvisingReq1: Record "Advising Request";
    //     AdvisingReq2: Record "Advising Request";
    //     AdvisingReq3: Record "Advising Request";
    //     AdvisingRequest: record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    //     EmailAddress: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     IF "Department Type" <> "Department Type"::"EED Clinical" then
    //         Rec.TestField("Problem Solution Id 1");

    //     TestFields();
    //     // Informations();
    //     AdvisingReq.Reset();
    //     AdvisingReq.setrange("Request No", Rec."Rescheduled Old Req. No.");
    //     if AdvisingReq.FindFirst() then begin
    //         AdvisingReq.Validate("Request Status", "Request Status"::Completed);
    //         AdvisingReq.Modify();
    //         AdvisingReq1.Reset();
    //         AdvisingReq1.setrange("Request No", Rec."Rescheduled Old Req. No.");
    //         if AdvisingReq1.FindFirst() then begin
    //             AdvisingReq1.Validate("Request Status", "Request Status"::Completed);
    //             AdvisingReq1.Modify();
    //             AdvisingReq2.Reset();
    //             AdvisingReq2.setrange("Request No", Rec."Rescheduled Old Req. No.");
    //             if AdvisingReq2.FindFirst() then begin
    //                 AdvisingReq2.Validate("Request Status", "Request Status"::Completed);
    //                 AdvisingReq2.Modify();
    //                 AdvisingReq3.Reset();
    //                 AdvisingReq3.setrange("Request No", Rec."Rescheduled Old Req. No.");
    //                 if AdvisingReq3.FindFirst() then begin
    //                     AdvisingReq3.Validate("Request Status", "Request Status"::Completed);
    //                     AdvisingReq3.Modify();
    //                 end;
    //             end;
    //         end;
    //     end;
    //     // FOR MAIL +
    //     SmtpMailRec.Get();
    //     // if EduSetup.Get('AUA') then
    //     //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         if employeeRec.Get(Rec."Advisor ID") then;
    //         employeeRec.TESTFIELD(employeeRec."E-Mail");
    //         if Studentmaster.GET(rec."Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         Recipient := Studentmaster."E-Mail Address";
    //         //Recipient := 'Sumit.n@siriusdynamics.com';
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'SLcM System Administrator';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'SLcM: Advising Appointment – Meeting Update';
    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //         SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Thank you for meeting with the ' + employeeRec.Title + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ' for your Advising Appointment. Please contact the ' + employeeRec.Title + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ' directly for any additional questions that you may have.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The SLcM System has added this appointment to the student’s Advising History.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Thanking You,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('SLcM System Administrator');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         // Send mail to admin +
    //         //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department IN [employeeRec.Department::"EED Clinical", employeeRec.Department::"EED Pre-Clinical"]) then
    //         AdvisingCompletedMailToAdmin();
    //         // Send mail to admin -

    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //         Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //         Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //     end;

    //     //for EED Pre-Clinical +
    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         SmtpMailRec.Get();
    //         // if EduSetup.Get('AUA') then
    //         //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //         if employeeRec.Get(Rec."Advisor ID") then;
    //         employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //         if Studentmaster.GET(rec."Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         Recipient := Studentmaster."E-Mail Address";
    //         // Recipient := 'Sumit.n@siriusdynamics.com';
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'SLcM System Administrator';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := "Request No" + ':Advising Appointment – Meeting Update';
    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //         SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Thank you for meeting with the Advisor for your Advising Appointment. The request has been closed as per the discussion. Please feel free to contact back to the Advisor if you have any additional questions.');
    //         // SmtpMail.AppendtoBody('<br><br>');
    //         // SmtpMail.AppendtoBody('The SLcM System has added this appointment to your account’s Advising History.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('We would like to request you to kindly click on the below link and complete the survey related to the meeting conducted.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<a href="https://www.surveymonkey.com/r/R82MQHX">https://www.surveymonkey.com/r/R82MQHX</a>');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Thanking You,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('SLcM System Administrator');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         // Send mail to admin +
    //         AdvisingCompletedMailToAdmin();
    //         // Send mail to admin -

    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //         Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //         Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //     end;
    //     //for EED Pre-Clinical -

    //     Rec.Validate("Request Status", "Request Status"::Completed);
    //     Rec.Modify();
    //     // Commit();
    //     // AdvisingRequest.reset();
    //     // if AdvisingRequest.findset() then;
    //     // Page.RunModal(Page::"App. Or Res. Adv. Req. Card", AdvisingRequest);
    // end;

    // procedure AdvisingCompletedMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     IF "Department Type" <> "Department Type"::"EED Clinical" then
    //         TestField("Problem Solution Id 1");
    //     // if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
    //     // DocApprover.Reset();
    //     // DocApprover.SetRange("User ID", UserId());
    //     // DocApprover.SetFilter("Department Approver Type", '<>%1', DocApprover."Department Approver Type"::"EED Pre-Clinical");
    //     // DocApprover.SetFilter("Department Approver Type", '%1&%2|%3', DocApprover."Department Approver Type"::"EED Clinical", DocApprover."Department Approver Type"::"EED Pre-Clinical", DocApprover."Department Approver Type"::"EED Clinical");
    //     // if DocApprover.FindSet() then begin
    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         if Studentmaster.Get("Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 EmailAddress := Studentmaster."E-Mail Address";
    //                 employeeRec2.TESTFIELD(employeeRec2."Company E-Mail");
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM:' + "Request No" + ' Advising Appointment – Meeting Update';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('The following student has completed their Advising Appointment with' + employeeRec.Title + ' ' + employeeRec.FullName + ': ');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."Last Name" + ',' + Studentmaster."First Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('The SLcM System has added this appointment to the student’s Advising History.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             until employeeRec2.Next = 0;
    //     end;

    //     // DocApprover.Reset();
    //     // DocApprover.SetRange("User ID", UserId());
    //     // DocApprover.SetRange("Department Approver Type", DocApprover."Department Approver Type"::"EED Pre-Clinical");
    //     // if DocApprover.FindFirst() then begin
    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         if Studentmaster.Get("Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Pre-Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 BodyText := '';
    //                 SmtpMailRec.Get();
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 employeeRec2.TESTFIELD("Company E-Mail");
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := "Request No" + ':Advising Appointment – Meeting Update';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('The following student has completed their Advising Appointment with ' + employeeRec.Title + ' ' + employeeRec.FullName + ':');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Student ID - ' + "Student No." + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<ul><li> Student Name - ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('The SLcM System has added this appointment to the student’s Advising History.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             until employeeRec2.Next = 0;
    //     end;
    // end;

    // procedure AdvisingCancelMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     BodyText := '';
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if Studentmaster.Get("Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     employeeRec2.Reset();
    //     employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //     employeeRec2.SetRange("Administrative Assistant", true);
    //     IF employeeRec2.FindSet() then
    //         repeat
    //             SmtpMailRec.Get();
    //             BodyText := '';
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             employeeRec2.TESTFIELD(employeeRec2."E-Mail");
    //             employeeRec2.TestField(employeeRec2."Company E-Mail");
    //             EmailAddress := employeeRec."Company E-Mail";
    //             Recipient := employeeRec2."Company E-Mail";
    //             // Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'SLcM System Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := 'SLcM:' + "Request No" + ' Advising Appointment Request – Cancelled by Clinical EED Faculty/Clinical Chair';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair has cancelled the Appointment Request.');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '</li>');
    //             SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + Employeerec.FullName() + '</li>');
    //             SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('SLcM System Administrator');
    //             BodyText := SmtpMail.GetBody();
    //             Mail_lCU.Send();

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //             '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //         until employeeRec2.Next = 0;
    // end;

    // procedure CancelRequest()
    // var
    //     employeeRec: Record Employee;
    //     Studentmaster: Record "Student Master-CS";
    //     SmtpMailRec: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WEbServiceFn: Codeunit WebServicesFunctionsCSL;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[200];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text[100];
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     Clear(EmailAddress);
    //     BodyText := '';
    //     //FOR MAIL +
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
    //     TestFields();

    //     if employeeRec.Get(Rec."Advisor ID") then;
    //     employeeRec.TESTFIELD(employeeRec."E-Mail");
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     EmailAddress := employeeRec."Company E-Mail";
    //     Recipient := Studentmaster."E-Mail Address";
    //     // Recipient := 'Sumit.n@siriusdynamics.com';
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'SLcM System Administrator';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Cancelled by Clinical EED Faculty';
    //     // Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Cancelled by Clinical EED Faculty/Clinical Chair';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your Appointment request has been cancelled by the EED Faculty');
    //     //SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair has cancelled your Appointment Request');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //     SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName() + '</li>');
    //     SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //     SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //     SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li>');
    //     SmtpMail.AppendtoBody('<li> Rejection Reason: ' + "Rejection Reason Description" + '</li></ul>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SmtpMail.AppendtoBody('<br><br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br><br>');
    //     SmtpMail.AppendtoBody('Thanking You,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('SLcM System Administrator');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     // Send mail to admin +
    //     // if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //     AdvisingCancelMailToAdmin();
    //     // Send mail to admin -

    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //                 Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    //     //FOR MAIL -
    //     Rec."Request Status" := Rec."Request Status"::Cancel;
    //     Rec.Modify();

    //     WebServiceFn.AdvisingRequestAzureMeetingCancellation(Rec);
    // end;

    // procedure AdvisingConfirmMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     BodyText := '';
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         if Requestor = Requestor::"By Student" then begin //Confirmed by faculty
    //             employeeRec2.Reset();
    //             employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //             employeeRec2.SetRange("Administrative Assistant", true);
    //             IF employeeRec2.FindSet() then
    //                 repeat
    //                     SmtpMailRec.Get();
    //                     BodyText := '';
    //                     if Studentmaster.Get("Student No.") then;
    //                     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                     if employeeRec.Get(Rec."Advisor ID") then;
    //                     employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //                     employeeRec2.TestField("Company E-Mail");
    //                     EmailAddress := employeeRec."Company E-Mail";
    //                     Recipient := employeeRec2."Company E-Mail";
    //                     // Recipient := 'Sumit.n@siriusdynamics.com';
    //                     Recipients := Recipient.Split(';');
    //                     SenderName := 'SLcM System Administrator';
    //                     SenderAddress := SmtpMailRec."Email Address";
    //                     Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Confirmed by Clinical EED';
    //                     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                     SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('An Appointment Request Confirmation from a Clinical EED has been received.');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName() + '</li>');
    //                     SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + ' EST' + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                     // SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                     SmtpMail.AppendtoBody('<br><br><br>');
    //                     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                     SmtpMail.AppendtoBody('<br><br><br>');
    //                     SmtpMail.AppendtoBody('Thanking You,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('SLcM System Administrator');
    //                     BodyText := SmtpMail.GetBody();
    //                     Mail_lCU.Send();

    //                     //FOR NOTIFICATION +
    //                     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                     '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 until employeeRec2.Next = 0;
    //         end;
    //     end;

    //     //FOR EED Pre-Clinical +
    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         if Requestor = Requestor::"By Student" then begin //Confirmed by faculty
    //             employeeRec2.Reset();
    //             employeeRec2.SetRange(Department, employeeRec2.Department::"EED Pre-Clinical");
    //             employeeRec2.SetRange("Administrative Assistant", true);
    //             IF employeeRec2.FindSet() then
    //                 repeat
    //                     SmtpMailRec.Get();
    //                     BodyText := '';
    //                     if Studentmaster.Get("Student No.") then;
    //                     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                     if employeeRec.Get(Rec."Advisor ID") then;
    //                     employeeRec.TESTFIELD("Company E-Mail");
    //                     EmailAddress := employeeRec."Company E-Mail";
    //                     employeeRec2.TestField("Company E-Mail");
    //                     Recipient := employeeRec2."Company E-Mail";
    //                     // Recipient := 'Sumit.n@siriusdynamics.com';
    //                     Recipients := Recipient.Split(';');
    //                     SenderName := 'SLcM System Administrator';
    //                     SenderAddress := SmtpMailRec."Email Address";
    //                     // Subject: <Advisory Number>: Advising Appointment Request – Confirmed by Advisor
    //                     Subject := "Request No" + ':Advising Appointment Request – Confirmed by Advisor';
    //                     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                     SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('An Appointment Request Confirmation from Advisor has been received.');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + '</li>');
    //                     SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + '/' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                     // SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('Thanking You,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('SLcM System Administrator');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                     BodyText := SmtpMail.GetBody();
    //                     Mail_lCU.Send();

    //                     //FOR NOTIFICATION +
    //                     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                     '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 until employeeRec2.Next = 0;
    //         end;
    //     end;
    //     //FOR EED Pre-Clinical -

    //     //FOR MAIL +
    //     if Requestor = Requestor::"By Faculty" then begin //Confirmed by student
    //         if Studentmaster.Get("Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         if employeeRec.Get(Rec."Advisor ID") then;
    //         employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //         EmailAddress := employeeRec."Company E-Mail";
    //         Recipient := employeeRec."Company E-Mail";
    //         // Recipient := 'Sumit.n@siriusdynamics.com';
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'SLcM System Administrator';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Confirmed by Student';
    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //         SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('An Appointment Request Confirmation from a student has been received.');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //         SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."first Name" + ' ' + Studentmaster."last Name" + '</li>');
    //         SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //         SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //         SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li></ul>');
    //         // SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Thanking You,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('SLcM System Administrator');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();
    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //         '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //         Recipient, 1, employeeRec."Mobile Phone No.", '', 1);
    //         //FOR NOTIFICATION -
    //     end;
    //     //FOR MAIL -
    // end;

    // procedure ConfirmRequest()
    // var
    //     employeeRec: Record Employee;
    //     Studentmaster: Record "Student Master-CS";
    //     SmtpMailRec: Record "Email Account";
    //     AdvisingRequest: record "Advising Request";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WEbServiceFn: Codeunit WebServicesFunctionsCSL;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[200];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text[100];
    //     EmailSetup: Record "EMail Setup";
    //     ConfirmDateError: Label 'Please select the Confirm Date option!';
    // begin
    //     if "Confirm Date" = "Confirm Date"::" " then
    //         Error(ConfirmDateError);

    //     //FOR MAIL +
    //     Clear(EmailAddress);
    //     BodyText := '';
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
    //     TestFields();
    //     if Rec."Rescheduled Old Req. No." = '' then begin // CSPL-20-10-21
    //         if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //             if Requestor = Requestor::"By Student" then begin //confirmed by faculty
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 if Studentmaster.GET(rec."Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 Recipient := Studentmaster."E-Mail Address";
    //                 //Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Confirmed by Clinical EED Faculty/Clinical Chair';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair confirmed your Appointment Request.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName() + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 // Send mail to admin +
    //                 //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //                 AdvisingConfirmMailToAdmin();
    //                 // Send mail to admin -

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //                 Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 //FOR MAIL -
    //             end;
    //         end;

    //         //For EED Pre-Clinical +
    //         if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //             if Requestor = Requestor::"By Student" then begin //confirmed by faculty
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 if Studentmaster.GET(rec."Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 Recipient := Studentmaster."E-Mail Address";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := "Request No" + ':Advising Appointment Request – Confirmed by Advisor';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('An Appointment Request Confirmation from Advisor has been received.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + '</li>');
    //                 // SmtpMail.AppendtoBody('<li>' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 // Send mail to admin +
    //                 AdvisingConfirmMailToAdmin();
    //                 // Send mail to admin -

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //                 Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 //FOR MAIL -
    //             end;
    //         end;
    //         //For Basic Science -

    //         //FOR MAIL +
    //         if Requestor = Requestor::"By Faculty" then begin  //confirmed by student
    //             if Studentmaster.Get("Student No.") then;
    //             Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             EmailAddress := employeeRec."Company E-Mail";
    //             employeeRec.TESTFIELD(employeeRec."E-Mail");
    //             Recipient := employeeRec."E-Mail";
    //             // Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'SLcM System Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Confirmed by Student';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear' + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ',');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('An Appointment Request Confirmation from a student has been received.');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."first Name" + ' ' + Studentmaster."last Name" + '</li>');
    //             SmtpMail.AppendtoBody('<li> Student No.: ' + Studentmaster."No." + '</li>');
    //             SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li></ul>');
    //             // SmtpMail.AppendtoBody('<br><br>'); 
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('SLcM System Administrator');
    //             BodyText := SmtpMail.GetBody();
    //             // for mail send to student or faculty +
    //             DocumentApprover.Reset();
    //             DocumentApprover.SetRange("User ID", UserId());
    //             if DocumentApprover.FindSet() then begin
    //                 repeat
    //                     EmailSetup.Reset();
    //                     EmailSetup.SetRange("Employee No.", employeeRec."No.");
    //                     EmailSetup.SetRange("Email Enabled", true);
    //                     EmailSetup.SetRange("Email Alert Type", EmailSetup."Email Alert Type"::"Advising Module");
    //                     EmailSetup.SetRange("Department Type", DocumentApprover."Department Approver Type");
    //                     if EmailSetup.FindFirst() then begin
    //                         Mail_lCU.Send();
    //                     end;
    //                 until DocumentApprover.Next() = 0;
    //             end;
    //             // for mail send to Student or faculty -

    //             // Send mail to admin +
    //             //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //             AdvisingConfirmMailToAdmin();
    //             // Send mail to admin -

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, employeeRec."Full Name",
    //             Format(employeeRec."No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, employeeRec."Mobile Phone No.", '', 1);
    //             //FOR NOTIFICATION -
    //         end;
    //         //FOR MAIL -
    //     end else
    //         if Rec."Rescheduled Old Req. No." <> '' then begin
    //             if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //                 SmtpMailRec.Get();
    //                 if EduSetup.Get('AUA') then
    //                     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 if Studentmaster.GET(rec."Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 Recipient := Studentmaster."E-Mail Address";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM:' + "Request No" + ' Advising Appointment Request – Re-scheduled by Clinical EED Faculty/Clinical Chair';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A Clinical EED Faculty/Clinical Chair has rescheduled your Appointment Request.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No.: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + ',Student: ' + Studentmaster."First Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<li>' + Rec."Reason Program Code" + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 // Send mail to admin +
    //                 //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //                 AdvisingReScheduleMailToAdmin();
    //                 // Send mail to admin -

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //                 Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 WebserviceFn.AdvisingRequestAzureMeetingCancellation(Rec);
    //                 //FOR NOTIFICATION -
    //             end;
    //             // end;
    //             //FOR MAIL -

    //             // DocApprover.Reset();
    //             // DocApprover.SetRange("User ID", UserId());
    //             // DocApprover.SetRange("Department Approver Type", DocApprover."Department Approver Type"::"EED Pre-Clinical");
    //             // if DocApprover.FindFirst() then begin
    //             if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //                 SmtpMailRec.Get();
    //                 // if EduSetup.Get('AUA') then
    //                 //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 if Studentmaster.GET(rec."Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 Recipient := Studentmaster."E-Mail Address";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := "Request No" + ':Advising Appointment – Meeting Update';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 // SmtpMail.AppendtoBody('Thank you for meeting with ' + employeeRec.Title + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ' for your Advising Appointment. As per the discussion your next follow-up details are as below:');
    //                 SmtpMail.AppendtoBody('As per the discussion, your next follow-up details are as below:');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Follow-up date: ' + Format("Meeting Date") + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Follow-up time: ' + Format("Meeting Mode") + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advising Topic: ' + "Advising Topic Description" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('The SLcM System has added this appointment to your account’s Advising History.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 // SmtpMail.AppendtoBody('We would like to request you to kindly click on the below link and complete the survey related to the meeting conducted.');
    //                 // SmtpMail.AppendtoBody('<br><br>');
    //                 // SmtpMail.AppendtoBody('https://www.surveymonkey.com/r/R82MQHX');
    //                 // SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 // Send mail to admin +
    //                 AdvisingReScheduleMailToAdmin();
    //                 // Send mail to admin -

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //                 Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 WebserviceFn.AdvisingRequestAzureMeetingCancellation(Rec);
    //                 //FOR NOTIFICATION -
    //             end;
    //         end;
    //     Rec.Validate("Request Status", "Request Status"::Approved);
    //     WEbServiceFn.CreateAzureCalendarMeeting(Rec);
    //     Rec.Modify(false);

    //     // Commit();
    //     // AdvisingRequest.Reset();
    //     // if AdvisingRequest.findset() then;
    //     // Page.RunModal(Page::"Advising Request List", AdvisingRequest);
    // end;

    // procedure AdvisingRejectMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[200];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     BodyText := '';
    //     TestField("Rejected Reason");
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     // EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         if Requestor = Requestor::"By Student" then begin //Rejected by faculty
    //             employeeRec2.Reset();
    //             employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //             employeeRec2.SetRange("Administrative Assistant", true);
    //             IF employeeRec2.FindSet() then
    //                 repeat
    //                     SmtpMailRec.Get();
    //                     BodyText := '';
    //                     if Studentmaster.Get("Student No.") then;
    //                     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                     if employeeRec.Get(Rec."Advisor ID") then;
    //                     employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //                     employeeRec2.TestField(employeeRec2."Company E-Mail");
    //                     EmailAddress := employeeRec."Company E-Mail";
    //                     Recipient := employeeRec2."Company E-Mail";
    //                     // Recipient := 'Sumit.n@siriusdynamics.com';
    //                     Recipients := Recipient.Split(';');
    //                     SenderName := 'SLcM System Administrator';
    //                     SenderAddress := SmtpMailRec."Email Address";
    //                     Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Rejected by Clinical EED Faculty/Clinical Chair';
    //                     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                     SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('An Appointment Request from a Clinical EED Faculty/Clinical has been rejected.');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                     SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName() + '</li>');
    //                     SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                     //SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") +' EST'+' EST'+ '</li>');
    //                     SmtpMail.AppendtoBody('<li> Rejection Reason: ' + "Rejection Reason Description" + '</li></ul>');
    //                     // SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                     SmtpMail.AppendtoBody('<br><br><br>');
    //                     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                     SmtpMail.AppendtoBody('<br><br><br>');
    //                     SmtpMail.AppendtoBody('Thanking You,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('SLcM System Administrator');
    //                     BodyText := SmtpMail.GetBody();
    //                     Mail_lCU.Send();
    //                     //FOR NOTIFICATION +
    //                     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                     '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 until employeeRec2.Next = 0;
    //         end;
    //     end;

    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         if Requestor = Requestor::"By Student" then begin //Rejected by faculty
    //             employeeRec2.Reset();
    //             employeeRec2.SetRange(Department, employeeRec2.Department::"EED Pre-Clinical");
    //             employeeRec2.SetRange("Administrative Assistant", true);
    //             IF employeeRec2.FindSet() then
    //                 repeat
    //                     SmtpMailRec.Get();
    //                     BodyText := '';
    //                     if Studentmaster.Get("Student No.") then;
    //                     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                     if employeeRec.Get(Rec."Advisor ID") then;
    //                     employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //                     employeeRec2.TestField(employeeRec2."Company E-Mail");
    //                     Recipient := employeeRec2."Company E-Mail";
    //                     // Recipient := 'Sumit.n@siriusdynamics.com';
    //                     Recipients := Recipient.Split(';');
    //                     SenderName := 'SLcM System Administrator';
    //                     SenderAddress := SmtpMailRec."Email Address";
    //                     Subject := "Request No" + ':Advising Appointment Request – Rejected by Advisor';
    //                     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                     SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('An Appointment Request ' + "Request No" + ' from Advisor ' + employeeRec.Title + ' ' + employeeRec2.FullName() + ' has been rejected.');
    //                     SmtpMail.AppendtoBody('<br>');
    //                     // SmtpMail.AppendtoBody('<ul><li>' + employeeRec."Last Name" + ',' + employeeRec."First Name" + '</li></ul>');
    //                     // SmtpMail.AppendtoBody('<br>');
    //                     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                     SmtpMail.AppendtoBody('<br><br><br>');
    //                     SmtpMail.AppendtoBody('Thanking You,');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('SLcM System Administrator');
    //                     SmtpMail.AppendtoBody('<br><br>');
    //                     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                     BodyText := SmtpMail.GetBody();
    //                     Mail_lCU.Send();
    //                     //FOR NOTIFICATION +
    //                     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                     '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //                 //FOR NOTIFICATION -
    //                 until employeeRec2.Next = 0;
    //         end;
    //     end;

    //     //FOR MAIL +
    //     if Requestor = Requestor::"By Faculty" then begin //rejected by student
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if Studentmaster.Get("Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 EmailAddress := Studentmaster."E-Mail Address";
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec2.TESTFIELD("Company E-Mail");
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 // Recipient := 'Sumit.n@siriusdynamics.com';
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Rejected by Student.';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A student has rejected an appointment request.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('This rejection will be noted in the student’s file.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."first Name" + ' ' + Studentmaster."last Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Reject Reason: ' + "Rejection Reason Description" + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('This rejection will be noted in the student’s file.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();
    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, employeeRec."Mobile Phone No.", '', 1);
    //             //FOR NOTIFICATION -
    //             Until employeeRec2.Next = 0;
    //     end;
    //     //FOR MAIL -
    // end;

    // procedure RejectRequest()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     //FOR MAIL +
    //     BodyText := '';
    //     SmtpMailRec.Get();
    //     TestField("Rejected Reason");
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     if EduSetup.Get('AUA') then;
    //     //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if ((DeprtMentIsCleanincal()) and (DepartmentIsBasicScience())) or (DeprtMentIsCleanincal()) then begin
    //         if Requestor = Requestor::"By Student" then begin //Rejected by faculty
    //             if Studentmaster.Get("Student No.") then;
    //             Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //             EmailAddress := employeeRec."Company E-Mail";
    //             Recipient := Studentmaster."E-Mail Address";
    //             // Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'SLcM System Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Rejected by Clinical EED Faculty/Clinical Chair';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('An Appointment Request has been rejected.');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName() + '</li>');
    //             SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //             //SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") +' EST'+' EST'+ '</li>');
    //             SmtpMail.AppendtoBody('<li> Reject Reason: ' + "Rejection Reason Description" + '</li></ul>');
    //             // SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('SLcM System Administrator');
    //             BodyText := SmtpMail.GetBody();
    //             Mail_lCU.Send();

    //             // Send mail to admin +
    //             //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //             AdvisingRejectMailToAdmin();
    //             // Send mail to admin -

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //             Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //         end;
    //     end;

    //     //For EED Pre-Clinical +
    //     if (DepartmentIsBasicScience()) and (DeprtMentIsCleanincal() = false) then begin
    //         if Requestor = Requestor::"By Student" then begin //Rejected by faculty
    //             if Studentmaster.Get("Student No.") then;
    //             Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             EmailAddress := employeeRec."Company E-Mail";
    //             employeeRec.TESTFIELD(employeeRec."E-Mail");
    //             Recipient := Studentmaster."E-Mail Address";
    //             // Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'Student Portal Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := "Request No" + ':Advising Appointment Request – Rejected by Advisor';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('An Appointment Request from Advisor  ' + employeeRec.Title + ' ' + employeeRec.FullName + ' has been rejected.');
    //             SmtpMail.AppendtoBody('<br>');
    //             // SmtpMail.AppendtoBody('<ul><li>' + employeeRec."Last Name" + ',' + employeeRec."First Name" + '</li></ul>');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('Student Portal Administrator');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             BodyText := SmtpMail.GetBody();
    //             Mail_lCU.Send();

    //             // Send mail to admin +
    //             AdvisingRejectMailToAdmin();
    //             // Send mail to admin -

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //             Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //         end;
    //     end;
    //     //For EED Pre-Clinical -  

    //     //FOR MAIL +
    //     if Requestor = Requestor::"By Faculty" then begin //Rejected by student
    //         if Studentmaster.Get("Student No.") then;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         EmailAddress := Studentmaster."E-Mail Address";
    //         if employeeRec.Get(Rec."Advisor ID") then;
    //         EmailAddress := employeeRec."Company E-Mail";
    //         employeeRec.TESTFIELD(employeeRec."E-Mail");
    //         Recipient := employeeRec."E-Mail";
    //         // Recipient := 'Sumit.n@siriusdynamics.com';
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'SLcM System Administrator';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Rejected by Student';
    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear' + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ': ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         // SmtpMail.AppendtoBody('A student has rejected an appointment request.');
    //         SmtpMail.AppendtoBody('An Appointment Request Confirmation from a student has been rejected.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('This rejection will be noted in the student’s file.');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '</li>');
    //         SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."Last Name" + ' ' + Studentmaster."First Name" + '</li>');
    //         SmtpMail.AppendtoBody('<li> Student No.: ' + Studentmaster."No." + '</li>');
    //         SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //         SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //         SmtpMail.AppendtoBody('<li> Rejection Reason: ' + "Rejected Reason" + '</li></ul>');
    //         // SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('This rejection will be noted in the student’s file.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Thanking You,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('SLcM System Administrator');
    //         BodyText := SmtpMail.GetBody();
    //         DocumentApprover.Reset();
    //         DocumentApprover.SetRange("User ID", UserId());
    //         if DocumentApprover.FindSet() then begin
    //             repeat
    //                 EmailSetup.Reset();
    //                 EmailSetup.SetRange("Employee No.", employeeRec."No.");
    //                 EmailSetup.SetRange("Email Enabled", true);
    //                 EmailSetup.SetRange("Email Alert Type", EmailSetup."Email Alert Type"::"Advising Module");
    //                 EmailSetup.SetRange("Department Type", DocumentApprover."Department Approver Type");
    //                 if EmailSetup.FindFirst() then begin
    //                     Mail_lCU.Send();
    //                 end;
    //             until DocumentApprover.Next() = 0;
    //         end;
    //         // Send mail to admin +
    //         if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //             AdvisingRejectMailToAdmin();
    //         // Send mail to admin -

    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, employeeRec."Full Name",
    //         Format(employeeRec."No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //         Recipient, 1, employeeRec."Mobile Phone No.", '', 1);
    //         //FOR NOTIFICATION -
    //     end;
    //     //FOR MAIL

    //     Rec.Validate("Request Status", "Request Status"::Rejected);
    //     Rec.Modify(false);

    //     // Commit();
    //     // AdvisingRequest.reset();
    //     // if AdvisingRequest.findset() then;
    //     // Page.RunModal(Page::"Advising Request List", AdvisingRequest);
    // end;

    // procedure AdvisingCreateMailToAdmin()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     BodyText := '';
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     // if EduSetup.Get('AUA') then
    //     //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if Requestor = Requestor::"By Student" then begin //by faculty
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if Studentmaster.Get("Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 employeeRec.TESTFIELD(employeeRec."E-Mail");
    //                 employeeRec2.TestField("Company E-Mail");
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Received';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A new Appointment Request from Student has been received.');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."first Name" + ' ' + Studentmaster."last Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li></ul>');
    //                 // SmtpMail.AppendtoBody('<li>' + Format("Meeting Mode") + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             until employeeRec2.Next = 0;
    //     end;

    //     if Requestor = Requestor::"By Faculty" then begin //by student
    //         employeeRec2.Reset();
    //         employeeRec2.SetRange(Department, employeeRec2.Department::"EED Clinical");
    //         employeeRec2.SetRange("Administrative Assistant", true);
    //         IF employeeRec2.FindSet() then
    //             repeat
    //                 SmtpMailRec.Get();
    //                 BodyText := '';
    //                 if Studentmaster.Get("Student No.") then;
    //                 Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //                 if employeeRec.Get(Rec."Advisor ID") then;
    //                 employeeRec2.TESTFIELD("Company E-Mail");
    //                 EmailAddress := employeeRec."Company E-Mail";
    //                 Recipient := employeeRec2."Company E-Mail";
    //                 Recipients := Recipient.Split(';');
    //                 SenderName := 'SLcM System Administrator';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := 'SLcM: ' + "Request No" + ' Advising Appointment Request – Received';
    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 SmtpMail.AppendtoBody('Dear Administrative Assistant,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('A new Appointment Request from ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ' has been received.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.Title + ' ' + employeeRec.FullName + ',Student: ' + Studentmaster."First Name" + '</li>');
    //                 SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + ' EST' + '</li>');
    //                 SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //                 SmtpMail.AppendtoBody('<br><br><br>');
    //                 SmtpMail.AppendtoBody('Thanking You,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('SLcM System Administrator');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();

    //                 //FOR NOTIFICATION +
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, 'Administrative',
    //                 '', Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //             until employeeRec2.Next = 0;
    //     end;
    //     //FOR MAIL -
    // end;

    // procedure CreateRequest()
    // var
    //     employeeRec: Record Employee;
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     EmailAddress: Text;
    //     AdvisingRequest: Record "Advising Request";
    //     EmailSetup: Record "EMail Setup";
    // begin
    //     BodyText := '';
    //     Clear(EmailAddress);
    //     SmtpMailRec.Get();
    //     // if EduSetup.Get('AUA') then
    //     //     EmailAddress := EduSetup."E-mail ID (SalesForce Log)";

    //     if "Advising Flag" = true then begin
    //         if Requestor = Requestor::"By Faculty" then begin
    //             if Studentmaster.Get("Student No.") then;
    //             Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //             Recipient := Studentmaster."E-Mail Address";
    //             EmailAddress := employeeRec."Company E-Mail";
    //             //Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'SLcM System Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             IF Rec."Request to Chair" THEN //CSPL-00307
    //                 Subject := 'SLcM: ' + "Request No" + ' Clinical EED Faculty/Clinical Chair Advising Appointment Request – Received'
    //             else
    //                 Subject := 'SLcM: ' + "Request No" + 'EED Faculty Advising Appointment Request – Received';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + ',');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             IF Rec."Request to Chair" THEN //CSPL-00307
    //                 SmtpMail.AppendtoBody('You have received an Advising Appointment Request from the following Clinical EED Faculty/Clinical Chair:')
    //             else
    //                 SmtpMail.AppendtoBody('You have received an Advising Appointment Request from the following EED Faculty:');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Advisor: ' + employeeRec.FullName + '</li>');
    //             // SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."First Name" + ' ' + Studentmaster."Last Name" + '</li>');
    //             SmtpMail.AppendtoBody('<li> Advisor Email ID: ' + EmailAddress + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ',' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + ' EST' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Mode: ' + Format("Meeting Mode") + '</li></ul>');
    //             Smtpmail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('You have 48 hours to respond to this Advising Appointment Request. If you fail to respond to this request, it will be noted in your file.');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('SLcM System Administrator');
    //             BodyText := SmtpMail.GetBody();
    //             Mail_lCU.Send();

    //             // Send mail to admin +
    //             if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //                 AdvisingCreateMailToAdmin();
    //             // Send mail to admin -

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //             Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             //FOR NOTIFICATION -
    //         end;

    //         if Requestor = Requestor::"By Student" then begin
    //             if Studentmaster.Get("Student No.") then;
    //             Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //             if employeeRec.Get(Rec."Advisor ID") then;
    //             employeeRec.TESTFIELD(employeeRec."Company E-Mail");
    //             EmailAddress := employeeRec."Company E-Mail";
    //             Recipient := employeeRec."E-Mail";
    //             // Recipient := 'Sumit.n@siriusdynamics.com';
    //             Recipients := Recipient.Split(';');
    //             SenderName := 'SLcM System Administrator';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := 'SLcM: ' + "Request No" + ' Student Advising Appointment Request – Received';
    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear' + ' ' + employeeRec."First Name" + ' ' + employeeRec."Last Name" + ',');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('A new Appointment Request from a student has been received.');
    //             // SmtpMail.AppendtoBody('You have received an Advising Appointment Request from the following Student:');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('<ul><li> Request No: ' + "Request No" + '.' + '</li>');
    //             SmtpMail.AppendtoBody('<li> Student: ' + Studentmaster."Last Name" + ' ' + Studentmaster."First Name" + '</li>');
    //             SmtpMail.AppendtoBody('<li> Student No.: ' + "Student No." + '</li>');
    //             SmtpMail.AppendtoBody('<li> AUA Email ID: ' + EmailAddress + '</li>');
    //             SmtpMail.AppendtoBody('<li> Meeting Date and Time: ' + Format("Meeting Date") + ', ' + Format("Meeting Start Time 1") + ' - ' + Format("Meeting End Time 1") + '</li></ul>');
    //             // SmtpMail.AppendtoBody('<li>' + Format("Meeting Mode") + '</li></ul>');
    //             // Smtpmail.AppendtoBody('<br>');
    //             // SmtpMail.AppendtoBody('You have 48 hours to respond to this Advising Appointment Request. If you fail to respond to this request, it will be noted in your file.');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //             SmtpMail.AppendtoBody('<br><br><br>');
    //             SmtpMail.AppendtoBody('Thanking You,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('SLcM System Administrator');
    //             BodyText := SmtpMail.GetBody();
    //             DocumentApprover.Reset();
    //             DocumentApprover.SetRange("User ID", UserId());
    //             if DocumentApprover.FindSet() then begin
    //                 repeat
    //                     EmailSetup.Reset();
    //                     EmailSetup.SetRange("Employee No.", employeeRec."No.");
    //                     EmailSetup.SetRange("Email Enabled", true);
    //                     EmailSetup.SetRange("Email Alert Type", EmailSetup."Email Alert Type"::"Advising Module");
    //                     EmailSetup.SetRange("Department Type", DocumentApprover."Department Approver Type");
    //                     if EmailSetup.FindFirst() then begin
    //                         Mail_lCU.Send();
    //                     end;
    //                 until DocumentApprover.Next() = 0;
    //             end;

    //             // Send mail to admin +
    //             //if (employeeRec."Administrative Assistant" = true) and (employeeRec.Department = employeeRec.Department::"EED Clinical") then
    //             AdvisingCreateMailToAdmin();
    //             // Send mail to admin -

    //             //FOR NOTIFICATION +
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, employeeRec."Full Name",
    //             Format(employeeRec."No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Request No"), Format("Request Date", 0, 9),
    //             Recipient, 1, employeeRec."Mobile Phone No.", '', 1);
    //             //FOR NOTIFICATION -
    //         end;
    //         "Advising Flag" := false;//For flagTASK000778
    //     end
    //     else
    //         Error('Mail already sent. You can send mail only once.');
    // end;

    var
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: Text[2048];
        employeeRec2: Record Employee;
}