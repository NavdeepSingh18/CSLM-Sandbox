report 50047 "Program Result CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Program Result CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption='Program Result';
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("Enrollment No.")
                                ORDER(Ascending);
            RequestFilterFields = Graduation, "Course Code", "Student Status", "Academic Year", "Enrollment No.";
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(EnrollmentNo_StudentCOLLEGE; "Student Master-CS"."Enrollment No.")
            {
            }
            column(NameasonCertificate_StudentCOLLEGE; "Student Master-CS"."Name as on Certificate")
            {
            }
            column(NetSemesterCGPA_StudentCOLLEGE; "Student Master-CS"."Net Semester CGPA")
            {
            }
            column(SemesterICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester I Credit Earned")
            {
            }
            column(SemesterIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester II Credit Earned")
            {
            }
            column(SemesterIIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester III Credit Earned")
            {
            }
            column(SemesterIVCreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester IV Credit Earned")
            {
            }
            column(SemesterVCreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester V Credit Earned")
            {
            }
            column(SemesterVICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VI Credit Earned")
            {
            }
            column(SemesterVIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VII Credit Earned")
            {
            }
            column(SemesterVIIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VIII Credit Earned")
            {
            }
            column(SemesterIGPA_StudentCOLLEGE; "Student Master-CS"."Semester I GPA")
            {
            }
            column(SemesterIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester II GPA")
            {
            }
            column(SemesterIIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester III GPA")
            {
            }
            column(SemesterIVGPA_StudentCOLLEGE; "Student Master-CS"."Semester IV GPA")
            {
            }
            column(SemesterVGPA_StudentCOLLEGE; "Student Master-CS"."Semester V GPA")
            {
            }
            column(SemesterVIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VI GPA")
            {
            }
            column(SemesterVIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VII GPA")
            {
            }
            column(SemesterVIIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VIII GPA")
            {
            }
            column(TotalCount; TotalCount)
            {
            }
            column(TotalCreditEarned; TotalCreditEarned)
            {
            }
            column(TotalCredit1Sem; TotalCredit1Sem)
            {
            }
            column(TotalCredit2Sem; TotalCredit2Sem)
            {
            }
            column(TotalCredit3Sem; TotalCredit3Sem)
            {
            }
            column(TotalCredit4Sem; TotalCredit4Sem)
            {
            }
            column(TotalCredit5Sem; TotalCredit5Sem)
            {
            }
            column(TotalCredit6Sem; TotalCredit6Sem)
            {
            }
            column(TotalCredit7Sem; TotalCredit7Sem)
            {
            }
            column(TotalCredit8Sem; TotalCredit8Sem)
            {
            }
            column(WithTotalCredit; WithTotalCredit)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalCreditEarned := "Semester I Credit Earned" + "Semester II Credit Earned" + "Semester III Credit Earned" + "Semester IV Credit Earned" +
                                     "Semester V Credit Earned" + "Semester VI Credit Earned" + "Semester VII Credit Earned" + "Semester VIII Credit Earned";

                Count1 := 0;
                ECount1 := 0;
                TotalCount := 0;

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Grade, '%1|%2|%3', 'F', 'DT', 'I');
                IF MainStudentSubjectCS.findset() THEN
                    Count1 := MainStudentSubjectCS.count();

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Grade, '%1|%2|%3', 'F', 'DT', 'I');
                IF OptionalStudentSubjectCS.findset() THEN
                    ECount1 := OptionalStudentSubjectCS.count();

                TotalCount := Count1 + ECount1;




                IF WithTotalCredit = TRUE THEN BEGIN
                    //I Sem Credit
                    TotalCredit1 := 0;
                    ETotalCredit1 := 0;
                    TotalCredit1Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'I');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit1 := TotalCredit1 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'I');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit1 := ETotalCredit1 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit1Sem := TotalCredit1 + ETotalCredit1;
                    END;


                    //II Sem Credit
                    TotalCredit2 := 0;
                    ETotalCredit2 := 0;
                    TotalCredit2Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'II');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit2 := TotalCredit2 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'II');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit2 := ETotalCredit2 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit2Sem := TotalCredit2 + ETotalCredit2;
                    END;


                    //III Sem Credit
                    TotalCredit3 := 0;
                    ETotalCredit3 := 0;
                    TotalCredit3Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'III');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit3 := TotalCredit3 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'III');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit3 := ETotalCredit3 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                        TotalCredit3Sem := TotalCredit3 + ETotalCredit3;
                    END;


                    //IV Sem Credit
                    TotalCredit4 := 0;
                    EtotalCredit4 := 0;
                    TotalCredit4Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'IV');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit4 := TotalCredit4 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'IV');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                EtotalCredit4 := EtotalCredit4 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit4Sem := TotalCredit4 + EtotalCredit4;
                    END;


                    //V Sem Credit
                    TotalCredit5 := 0;
                    ETotalCredit5 := 0;
                    TotalCredit5Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'V');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit5 := TotalCredit5 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'V');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit5 := ETotalCredit5 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit5Sem := TotalCredit5 + ETotalCredit5;
                    END;


                    //VI Sem Credit
                    TotalCredit6 := 0;
                    ETotalCredit6 := 0;
                    TotalCredit6Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'VI');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit6 := TotalCredit6 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'VI');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit6 := ETotalCredit6 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit6Sem := TotalCredit6 + ETotalCredit6;
                    END;


                    //VII Sem Credit
                    TotalCredit7 := 0;
                    ETotalCredit7 := 0;
                    TotalCredit7Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'VII');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit7 := TotalCredit7 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'VII');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit7 := ETotalCredit7 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit7Sem := TotalCredit7 + ETotalCredit7;
                    END;


                    //VIII Sem Credit
                    TotalCredit8 := 0;
                    ETotalCredit8 := 0;
                    TotalCredit8Sem := 0;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Enrollment No", "Enrollment No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'VIII');
                    IF MainStudentSubjectCS.findset() THEN BEGIN
                        REPEAT
                            TotalCredit8 := TotalCredit8 + MainStudentSubjectCS.Credit;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No", "Enrollment No.");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Semester, 'VIII');
                        IF OptionalStudentSubjectCS.findset() THEN
                            REPEAT
                                ETotalCredit8 := ETotalCredit8 + OptionalStudentSubjectCS.Credit;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                        TotalCredit8Sem := TotalCredit8 + ETotalCredit8;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '09');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("With Total Credit"; WithTotalCredit)
                {
                    Caption = 'With Total Credit';
                    ToolTip = 'With Total Credit may have a value';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DimensionValue: Record "Dimension Value";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        TotalCreditEarned: Decimal;
        TotalCredit1: Integer;
        ETotalCredit1: Integer;
        TotalCredit1Sem: Integer;
        TotalCredit2: Integer;
        ETotalCredit2: Integer;
        TotalCredit2Sem: Integer;
        TotalCredit3: Integer;
        ETotalCredit3: Integer;
        TotalCredit3Sem: Integer;
        TotalCredit4: Integer;
        EtotalCredit4: Integer;
        TotalCredit4Sem: Integer;
        TotalCredit5: Integer;
        ETotalCredit5: Integer;
        TotalCredit5Sem: Integer;
        TotalCredit6: Integer;
        ETotalCredit6: Integer;
        TotalCredit6Sem: Integer;
        TotalCredit7: Integer;
        ETotalCredit7: Integer;
        TotalCredit7Sem: Integer;
        TotalCredit8: Integer;
        ETotalCredit8: Integer;
        TotalCredit8Sem: Integer;
        WithTotalCredit: Boolean;
        Count1: Integer;
        ECount1: Integer;
        TotalCount: Integer;
}

