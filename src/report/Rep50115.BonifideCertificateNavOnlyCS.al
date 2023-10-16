report 50115 "Bonifide CertificateNavOnlyCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bonifide CertificateNavOnlyCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Bonafide Certificate Nav Only';

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            column(EnrollmentNo_StudentCOLLEGE; "Enrollment No.")
            {
            }
            column(NameasonCertificate_StudentCOLLEGE; "Name as on Certificate")
            {
            }
            column(Semester_StudentCOLLEGE; Semester)
            {
            }
            column(StudentImage_StudentCOLLEGE; "Student Image")
            {
            }
            column(CourseType_StudentCOLLEGE; "Course Type")
            {
            }
            column(CourseName_StudentCOLLEGE; "Course Name")
            {
            }
            column(FathersName_StudentCOLLEGE; "Fathers Name")
            {
            }
            column(MothersName_StudentCOLLEGE; "Mothers Name")
            {
            }
            column(PassPortNo_StudentCOLLEGE; "Pass Port No.")
            {
            }
            column(MobileNumber_StudentCOLLEGE; "Mobile Number")
            {
            }
            column(EMailAddress_StudentCOLLEGE; "E-Mail Address")
            {
            }
            column(AadharCardNumber_StudentCOLLEGE; "Aadhar Card Number")
            {
            }
            column(Sem1; Sem1)
            {
            }
            column(PermanentAdd; PermanentAdd)
            {
            }
            column(AdYear; AdYear)
            {
            }
            column(AdYear1; AdYear1)
            {
            }
            column(A; A)
            {
            }
            column(B; B)
            {
            }
            column(Newstring; Newstring)
            {
            }
            column(DOB; DOB)
            {
            }

            trigger OnAfterGetRecord()
            begin

                PermanentAdd := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2 + ' ' + "Student Master-CS".City + ' ' + "Student Master-CS"."Post Code";

                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, "Student Master-CS".Semester);
                IF SemesterMasterCS.findfirst() THEN
                    Sem1 := SemesterMasterCS.Description;
                CASE Sem1 OF
                    '1st Sem':
                        Sem1 := 'FIRST SEMESTER';
                    '2nd Sem':
                        Sem1 := 'SECOND SEMESTER';
                    '3rd Sem':
                        Sem1 := 'THIRD SEMESTER';
                    '4th Sem':
                        Sem1 := 'FOURTH SEMESTER';
                    '5th Sem':
                        Sem1 := 'FIFTH SEMESTER';
                    '6th Sem':
                        Sem1 := 'SIXTH SEMESTER';
                    '7th Sem':
                        Sem1 := 'SEVENTH SEMESTER';
                    '8th Sem':
                        Sem1 := 'EIGHTH SEMESTER';
                    ELSE
                        Sem1 := ' ';
                END;

                IF ("Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::Student) OR ("Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::Casual) OR
                  ("Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::"Reject & Rejoin") OR ("Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::"NFT-Extended") THEN BEGIN
                    A := 'is';
                    B := 'Studying in the' + ' ' + Sem1;
                    Newstring := FORMAT("Student Master-CS"."Academic Year");
                    AdYear := COPYSTR(Newstring, 1, 4);
                    Newstring1 := FORMAT("Student Master-CS"."Academic Year");
                    AdYear1 := COPYSTR(Newstring1, 6, 9);
                END ELSE BEGIN
                    A := 'was';
                    B := 'Study';
                    Newstring := FORMAT("Student Master-CS"."Date of Joining");
                    AdYear := '20' + COPYSTR(Newstring, 7, 8);
                    Newstring1 := FORMAT("Student Master-CS"."Date of Leaving");
                    AdYear1 := '20' + COPYSTR(Newstring1, 7, 8);
                END;

                DOB := FORMAT("Student Master-CS"."Date of Birth");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SemesterMasterCS: Record "Semester Master-CS";
        PermanentAdd: Text[250];
        Sem1: Text[50];
        Newstring: Code[10];
        AdYear: Code[10];
        Newstring1: Code[10];
        AdYear1: Code[10];
        A: Text[10];
        B: Text[100];
        DOB: Code[20];
}