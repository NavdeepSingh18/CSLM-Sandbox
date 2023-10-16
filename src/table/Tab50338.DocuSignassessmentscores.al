table 50338 "DocuSign Assessment Scores"
{
    // DataClassification = CustomerContent;
    Caption = 'DocuSign Assessment Scores';
    DataClassification = CustomerContent;
    DrillDownPageID = "DocuSign Assessment Scores";
    LookupPageID = "DocuSign Assessment Scores";
    fields
    {
        field(1; "Rotation ID"; Code[20])
        {
            Caption = 'Rotation ID';
            DataClassification = CustomerContent;

        }
        field(2; "Rotation No."; Integer)
        {
            Caption = 'Rotation No.';
            DataClassification = CustomerContent;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(4; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(5; "Course Start Date"; Date)
        {
            Caption = 'Course Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "Course End Date"; Date)
        {
            Caption = 'Course End Date';
            DataClassification = CustomerContent;
        }
        field(7; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;
        }
        field(8; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(9; "Patient Care"; Option)
        {
            Caption = 'Patient Care';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(10; "Medical Knowledge"; Option)
        {
            Caption = 'Medical Knowledge';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(11; "Interpersonal and Comm. Skills"; Option)
        {
            Caption = 'Interpersonal and Communication Skills';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(12; "Practice Base Learn and Impro"; Option)
        {
            Caption = 'Practice Base Learning and Improvement';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(13; "System Based Learning"; Option)
        {
            Caption = 'System Based Learning';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(14; "Student Portfolio"; Option)
        {
            Caption = 'Student Portfolio';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";

        }
        field(15; "Professionalism"; Option)
        {
            Caption = 'Professionalism';
            DataClassification = CustomerContent;
            OptionMembers = " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        }
        field(16; "MPSE Comment"; Text[500])
        {
            Caption = 'MPSE Comment';
            DataClassification = CustomerContent;
        }
        field(17; "Assessment Total Score"; Decimal)
        {
            Caption = 'Assessment Total Score';
            DataClassification = CustomerContent;
        }
        field(18; "Assessment Percentage"; Decimal)
        {
            Caption = 'Assessment Percentage';
            DataClassification = CustomerContent;
        }
        field(19; "Assessment Weightage"; Decimal)
        {
            Caption = 'Assessment Weightage';
            DataClassification = CustomerContent;
        }
        field(20; "CCSSE Score"; Decimal)
        {
            Caption = 'CCSSE Score';
            DataClassification = CustomerContent;
        }

        field(21; "CCSSE Weightage"; Decimal)
        {
            Caption = 'CCSSE Weightage';
            DataClassification = CustomerContent;
        }
        field(22; "Final Percentage"; Decimal)
        {
            Caption = 'Final Percentage';
            DataClassification = CustomerContent;
        }
        field(23; Grade; Text[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(24; "Sent Date Time"; DateTime)
        {
            Caption = 'Sent Date Time';
            DataClassification = CustomerContent;
        }
        field(25; "Delivered Date Time"; DateTime)
        {
            Caption = 'Delivered Date Time';
            DataClassification = CustomerContent;
        }
        field(26; "Preceptor Signed Date Time"; DateTime)
        {
            Caption = 'Preceptor Signed Date Time';
            DataClassification = CustomerContent;
        }
        field(27; "Preceptor Name"; Text[100])
        {
            Caption = 'Preceptor Name';
            DataClassification = CustomerContent;
        }
        field(28; "DME Name"; Text[100])
        {
            Caption = 'DME Name';
            DataClassification = CustomerContent;
        }
        field(29; "DME Signed Date Time"; DateTime)
        {
            Caption = 'DME Signed Date Time';
            DataClassification = CustomerContent;
        }
        field(30; "Envelope ID"; Text[100])
        {
            Caption = 'Envelope ID';
            DataClassification = CustomerContent;
        }
        field(31; "Form No"; Integer)
        {
            Caption = 'Form No';
            DataClassification = CustomerContent;
        }

        field(32; "Course Group Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(33; "Course Group Description"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(34; Published; Boolean)
        {
            Caption = 'Published';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(35; "Clerkship Type"; Option)
        {
            Caption = 'Clerkship Type';
            DataClassification = CustomerContent;
            Editable = False;
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(36; "Rotation Entry No."; Integer)
        {
            Caption = 'Rotation Entry No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(37; "Used CCSSE Exam Date"; Date)
        {
            Caption = 'Used CCSSE Exam Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(38; "Used CCSSE Exam II Date"; Date)
        {
            Caption = 'Used CCSSE Exam II Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(39; "CCSSE Score II"; Decimal)
        {
            Caption = 'CCSSE Score II';
            DataClassification = CustomerContent;
        }
        field(40; "CCSSE Score III"; Decimal)
        {
            Caption = 'CCSSE Score III';
            DataClassification = CustomerContent;
        }
        field(41; "Evaluation Count"; Integer)
        {
            Caption = 'Evaluation Count';
            DataClassification = CustomerContent;
        }
        field(42; "Manual Grade"; Code[20])
        {
            Caption = 'Manual Grade';
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS";
        }
        field(43; "Manual Grade Assigned By"; Text[50])
        {
            Caption = 'Manual Grade Assigned By';
            DataClassification = CustomerContent;
        }
        field(44; "Manual Grade Assigned On"; Date)
        {
            Caption = 'Manual Grade Assigned On';
            DataClassification = CustomerContent;
        }
        field(45; "Published By"; Text[50])
        {
            Caption = 'Published By';
            DataClassification = CustomerContent;
        }
        field(46; "Published On"; Date)
        {
            Caption = 'Published On';
            DataClassification = CustomerContent;
        }
        field(47; "FIU Grading"; Boolean)
        {
            Caption = 'FIU Grading';
            DataClassification = CustomerContent;
        }
        Field(48; "First Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(49; "Last Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Used CCSSE Exam III Date"; Date)
        {
            Caption = 'Used CCSSE Exam III Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(51; "CCSSE Score IV"; Decimal)
        {
            Caption = 'CCSSE Score IV';
            DataClassification = CustomerContent;
        }
        field(52; "CCSSE Score V"; Decimal)
        {
            Caption = 'CCSSE Score IV';
            DataClassification = CustomerContent;
        }
        field(60; "Used CCSSE Exam IV Date"; Date)
        {
            Caption = 'Used CCSSE Exam IV Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(61; "Used CCSSE Exam V Date"; Date)
        {
            Caption = 'Used CCSSE Exam V Date';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(62; "Student Status"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field("Student No.")));
            Editable = false;
        }
        field(60000; "Hospital Name"; Text[100])
        {
            Caption = 'Hospital Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Roster Ledger Entry"."Hospital Name" where("Entry No." = field("Rotation Entry No.")));
        }
    }

    keys
    {
        key(PK; "Student No.", "Rotation No.", "Rotation ID")
        {

        }
    }

    procedure CalculateEvalCount_Sum()
    var
        CCSSEScoreConversion: Record "CCSSE Score Conversion";
        ClerkshipGrading: Record "Clerkship Grading";
        StudentSubjectExam: Record "Student Subject Exam";
        RLE: Record "Roster Ledger Entry";
        Vendor: Record Vendor;
        DSAS: Record "DocuSign Assessment Scores";
        ReceivedValue: Option " ",Outstanding,Competent,Adequate,"Inadequate-Remediation required","Not Observed/Insufficient Data";
        EvalCount: Integer;
        EvalSum: Decimal;
        EvalPercent: Decimal;
        GradePercent: Decimal;
        CCSSEScoreToUse: Decimal;
        FIUHospital: Boolean;
        CCSSEScoreUsed: Boolean;
    begin
        RLE.Reset();
        if RLE.Get("Rotation Entry No.") then; //CS:NAvdeep

        //IF RLE.Get("Rotation No.") then;

        Vendor.Reset();
        if not Vendor.Get(RLE."Hospital ID") then
            exit;

        FIUHospital := false;
        if (Vendor."FIU Hospital" = true) and (RLE."Clerkship Type" = RLE."Clerkship Type"::Core) then
            FIUHospital := true;

        "CCSSE Score" := 0;
        "CCSSE Score II" := 0;
        "CCSSE Score III" := 0;
        "CCSSE Score IV" := 0;
        "CCSSE Score V" := 0;

        //CSPL-00307 NO-SHOW
        "Used CCSSE Exam Date" := 0D;
        "Used CCSSE Exam II Date" := 0D;
        "Used CCSSE Exam III Date" := 0D;
        "Used CCSSE Exam IV Date" := 0D;
        "Used CCSSE Exam V Date" := 0D;
        ///CSPL-00307 NO-SHOW
        StudentSubjectExam.Reset();
        StudentSubjectExam.SetCurrentKey("Student No.", "Sitting Date");
        StudentSubjectExam.SetRange("Student No.", "Student No.");
        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
        StudentSubjectExam.SetRange("Core Clerkship Subject Code", "Course Group Code");
        if StudentSubjectExam.FindSet() then
            repeat
                if "CCSSE Score" = 0 then begin
                    "CCSSE Score" := StudentSubjectExam."Shelf Exam Value";
                    "Used CCSSE Exam Date" := StudentSubjectExam."Sitting Date";
                end
                else
                    if "CCSSE Score II" = 0 then begin
                        "CCSSE Score II" := StudentSubjectExam."Shelf Exam Value";
                        "Used CCSSE Exam II Date" := StudentSubjectExam."Sitting Date";
                    end
                    else
                        if "CCSSE Score III" = 0 then begin
                            "CCSSE Score III" := StudentSubjectExam."Shelf Exam Value";
                            "Used CCSSE Exam III Date" := StudentSubjectExam."Sitting Date";
                        end
                        else
                            if "CCSSE Score IV" = 0 then begin
                                "CCSSE Score IV" := StudentSubjectExam."Shelf Exam Value";
                                "Used CCSSE Exam IV Date" := StudentSubjectExam."Sitting Date";
                            end
                            else
                                if "CCSSE Score V" = 0 then begin
                                    "CCSSE Score V" := StudentSubjectExam."Shelf Exam Value";
                                    "Used CCSSE Exam V Date" := StudentSubjectExam."Sitting Date";
                                end;

                Modify();
            until StudentSubjectExam.Next() = 0;

        EvalCount := 0;
        EvalSum := 0;

        if FIUHospital = false then begin
            ////////////////////////////////////////////1//////////////////////////////////////////////////////
            ReceivedValue := "Patient Care";
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            /////////////////////////////////////////////2/////////////////////////////////////////////////////
            ReceivedValue := "Medical Knowledge";
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            //////////////////////////////////////////////3////////////////////////////////////////////////////
            ReceivedValue := "Interpersonal and Comm. Skills";
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ///////////////////////////////////////////////4///////////////////////////////////////////////////
            ReceivedValue := "Practice Base Learn and Impro";
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ////////////////////////////////////////////////5//////////////////////////////////////////////////
            ReceivedValue := "System Based Learning";
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            ////////////////////////////////////////////////6//////////////////////////////////////////////////
            ReceivedValue := Professionalism;
            if ReceivedValue = ReceivedValue::Outstanding then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 4;
            end;

            if ReceivedValue = ReceivedValue::Competent then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 3;
            end;

            if ReceivedValue = ReceivedValue::Adequate then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 2;
            end;

            if ReceivedValue = ReceivedValue::"Inadequate-Remediation required" then begin
                EvalCount := EvalCount + 1;
                EvalSum := EvalSum + 1;
            end;

            EvalPercent := 0;

            if "Clerkship Type" = "Clerkship Type"::Core then
                if EvalCount <> 0 then
                    EvalPercent := Round((EvalSum / EvalCount) / 4 * 70, 0.01, '=');

            if "Clerkship Type" <> "Clerkship Type"::Core then
                if EvalCount <> 0 then
                    EvalPercent := Round((EvalSum / EvalCount) / 4 * 100, 0.01, '=');

            "Assessment Percentage" := EvalPercent;
        end;

        if "Clerkship Type" = "Clerkship Type"::Core then begin
            CCSSEScoreToUse := 0;

            if "CCSSE Score" <> 0 then begin
                CCSSEScoreUsed := false;
                DSAS.Reset();
                DSAS.SetRange("Student No.", "Student No.");
                DSAS.SetRange("Course Group Code", "Course Group Code");
                DSAS.SetFilter("Rotation ID", '<>%1', "Rotation ID");
                if DSAS.FindSet() then
                    repeat
                        if "Used CCSSE Exam Date" = DSAS."Used CCSSE Exam Date" then
                            CCSSEScoreUsed := true;
                    until DSAS.Next() = 0;

                if CCSSEScoreUsed = false then
                    CCSSEScoreToUse := "CCSSE Score";
            end;

            if "CCSSE Score II" <> 0 then begin
                CCSSEScoreUsed := false;
                DSAS.Reset();
                DSAS.SetRange("Student No.", "Student No.");
                DSAS.SetRange("Course Group Code", "Course Group Code");
                DSAS.SetFilter("Rotation ID", '<>%1', "Rotation ID");
                if DSAS.FindSet() then
                    repeat
                        if "Used CCSSE Exam II Date" = DSAS."Used CCSSE Exam II Date" then
                            CCSSEScoreUsed := true;
                    until DSAS.Next() = 0;

                if CCSSEScoreUsed = false then
                    CCSSEScoreToUse := "CCSSE Score II";
            end;

            if "CCSSE Score III" <> 0 then begin
                CCSSEScoreUsed := false;
                DSAS.Reset();
                DSAS.SetRange("Student No.", "Student No.");
                DSAS.SetRange("Course Group Code", "Course Group Code");
                DSAS.SetFilter("Rotation ID", '<>%1', "Rotation ID");
                if DSAS.FindSet() then
                    repeat
                        if "Used CCSSE Exam III Date" = DSAS."Used CCSSE Exam III Date" then
                            CCSSEScoreUsed := true;
                    until DSAS.Next() = 0;

                if CCSSEScoreUsed = false then
                    CCSSEScoreToUse := "CCSSE Score III";
            end;

            if "CCSSE Score IV" <> 0 then begin
                CCSSEScoreUsed := false;
                DSAS.Reset();
                DSAS.SetRange("Student No.", "Student No.");
                DSAS.SetRange("Course Group Code", "Course Group Code");
                DSAS.SetFilter("Rotation ID", '<>%1', "Rotation ID");
                if DSAS.FindSet() then
                    repeat
                        if "Used CCSSE Exam IV Date" = DSAS."Used CCSSE Exam III Date" then
                            CCSSEScoreUsed := true;
                    until DSAS.Next() = 0;

                if CCSSEScoreUsed = false then
                    CCSSEScoreToUse := "CCSSE Score IV";
            end;

            if "CCSSE Score V" <> 0 then begin
                CCSSEScoreUsed := false;
                DSAS.Reset();
                DSAS.SetRange("Student No.", "Student No.");
                DSAS.SetRange("Course Group Code", "Course Group Code");
                DSAS.SetFilter("Rotation ID", '<>%1', "Rotation ID");
                if DSAS.FindSet() then
                    repeat
                        if "Used CCSSE Exam V Date" = DSAS."Used CCSSE Exam V Date" then
                            CCSSEScoreUsed := true;
                    until DSAS.Next() = 0;

                if CCSSEScoreUsed = false then
                    CCSSEScoreToUse := "CCSSE Score V";
            end;

            CCSSEScoreConversion.Reset();
            CCSSEScoreConversion.SetRange("Course Code", "Course Group Code");
            CCSSEScoreConversion.SetFilter("Effective Date", '<=%1', Today);
            CCSSEScoreConversion.SetRange(Score, CCSSEScoreToUse);
            if CCSSEScoreConversion.FindLast() then
                "CCSSE Weightage" := CCSSEScoreConversion."Score Value";
        end;

        GradePercent := "Assessment Percentage" + "CCSSE Weightage";

        if FIUHospital = true then begin
            GradePercent := "Assessment Percentage";
            "FIU Grading" := true;
        end;

        if FIUHospital = false then
            if (("Assessment Percentage" = 0) or ("CCSSE Weightage" = 0)) and ("Clerkship Type" = "Clerkship Type"::Core) then
                GradePercent := 0;

        Grade := '';
        "Final Percentage" := GradePercent;

        ClerkshipGrading.Reset();
        IF FIUHospital = false then begin
            ClerkshipGrading.SetRange("Clerkship Type", "Clerkship Type");
            if "Clerkship Type" = "Clerkship Type"::Core then
                ClerkshipGrading.SetRange("Course Code", "Course Group Code");
        end
        else
            ClerkshipGrading.SetRange("Hospital Category", ClerkshipGrading."Hospital Category"::FIU);
        ClerkshipGrading.SetFilter("Effective Date", '<=%1', Today);
        if ClerkshipGrading.FindSet() then
            repeat
                if (GradePercent >= ClerkshipGrading."Cut-off Start") and (GradePercent < ClerkshipGrading."Cut-off End" + 1) then
                    Grade := ClerkshipGrading."Grade Code";
            until ClerkshipGrading.Next() = 0;

        IF FIUHospital = false then begin //CSPL-00307 NO-SHOW
            IF ("CCSSE Score II" + "CCSSE Score III" + "CCSSE Score IV" + "CCSSE Score V" > 0) and ("CCSSE Weightage" = 0) then begin
                Grade := 'F';
            end else //CSPL-00307 NO-SHOW
                IF (("CCSSE Score II" + "CCSSE Score III" + "CCSSE Score IV" + "CCSSE Score V" = 0) and ("CCSSE Weightage" = 0)) Then begin
                    IF ("Used CCSSE Exam II Date" <> 0D) OR ("Used CCSSE Exam III Date" <> 0D) OR ("Used CCSSE Exam IV Date" <> 0D) OR ("Used CCSSE Exam V Date" <> 0D) then
                        Grade := 'F';
                end;//CSPL-00307 NO-SHOW
        end; //CSPL-00307 NO-SHOW

        Modify();
    end;
}