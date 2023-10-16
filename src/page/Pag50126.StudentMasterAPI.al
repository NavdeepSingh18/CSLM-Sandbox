page 50126 StudentMasterAPI
{
    PageType = API;
    Caption = 'Student Master';
    APIPublisher = 'sLcM';
    APIGroup = 'boTmind';
    APIVersion = 'v0.1';
    EntityName = 'student';
    EntitySetName = 'students';
    SourceTable = "Student Master-CS";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(no; Rec."No.")
                {
                    Caption = 'SLcM No.';
                }
                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
                // field(rollNo; Rec."Roll No.")
                // {
                //     Caption = 'Roll No.';
                // }
                field(studentName; Rec."Student Name")
                {
                    Caption = 'Student Name';
                }
                field(dateOfBirth; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                }
                field(citizenship; Rec.Citizenship)
                {
                    Caption = 'Citizenship';
                }
                field(academicYear; Rec."Academic Year")
                {
                    Caption = 'Academic Year';
                }
                field(term; Rec.Term)
                {
                    Caption = 'Term';
                }

                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(countryCode; Rec."Country Code")
                {
                    Caption = 'Country Code';
                }

                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(state; Rec.State)
                {
                    Caption = 'State';
                }
                field(originalStudentNo; Rec."Original Student No.")
                {
                    Caption = 'Student ID';
                }

                field(nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                }
                field(age; Rec.Age)
                {
                    Caption = 'Age';
                }


                field(admittedYear; Rec."Admitted Year")
                {
                    Caption = 'Admitted Year';
                }

                field(year; Rec.Year)
                {
                    Caption = 'Year';
                }
                field(maritalStatus; Rec."Marital Status")
                {
                    Caption = 'Marital Status';
                }

                field(scholarshipSource; Rec."Scholarship Source")
                {
                    Caption = 'Scholarship Code';
                }
                field(gPa; Rec."GPA Credits")
                {
                    Caption = 'GPA Credits';
                }
                field(year1GPA; Rec."Year 1 GPA")
                {
                    Caption = 'Year 1 GPA';
                }
                field(year2GPA; Rec."Year 2 GPA")
                {
                    Caption = 'Year 2 GPA';
                }
                field(year3GPA; Rec."Year 3 GPA")
                {
                    Caption = 'Year 3 GPA';
                }
                field(year4GPA; Rec."Year 4 GPA")
                {
                    Caption = 'Year 4 GPA';
                }
                field(ethnicity; Rec.Ethnicity)
                {
                    Caption = 'Ethnicity';
                }

                // field(maidenName; Rec."Maiden Name")
                // {
                //     Caption = 'Maiden Name';
                // }
                // field(accountPersonType; Rec."Account Person Type")
                // {
                //     Caption = 'Account Person Type';
                // }
                // field(schoolLevel; Rec."School Level")
                // {
                //     Caption = 'School Level';
                // }
                field(graduateGPA; Rec."Graduate GPA")
                {
                    Caption = 'Graduate GPA';
                }
                field(highSchoolGPA; Rec."High School GPA")
                {
                    Caption = 'High School GPA';
                }
                field(otherGPA; Rec."Other GPA")
                {
                    Caption = 'Other GPA';
                }
                field(permanentUSResident; Rec."Permanent U.S. Resident")
                {
                    Caption = 'Permanent U.S. Resident';
                }
                field(preReqGPA; Rec."Pre-Req GPA")
                {
                    Caption = 'Pre-Req GPA';
                }
                // field(primaryLeadSource; Rec."Primary Lead Source")
                // {
                //     Caption = 'Primary Lead Source';
                // }
                field(transferGPA; Rec."Transfer GPA")
                {
                    Caption = 'Transfer GPA';
                }
                field(digitID; Rec."18 Digit ID")
                {
                    Caption = 'Salesforce ID';
                }
                field(fafsaReceived; Rec."FAFSA Received")
                {
                    Caption = 'FAFSA Received';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(semester; Rec.Semester)
                {
                    Caption = 'Semester';
                }
                field(courseCode; Rec."Course Code")
                {
                    Caption = 'Course Code';
                }
                field(eMailAddress; Rec."E-Mail Address")
                {
                    Caption = 'E-Mail Address';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(enrollmentNo; Rec."Enrollment No.")
                {
                    Caption = 'Enrollment No.';
                }
                field(enrollmentOrder; Rec."Enrollment Order")
                {
                    Caption = 'Enrollment Order';
                }
                // field(newTerm; Rec."New Term")
                // {
                //     Caption = 'New Term';
                // }
                // field(newAcademicYear; Rec."New Academic Year")
                // {
                //     Caption = 'New Academic Year';
                // }
                field(grantCode1; Rec."Grant Code 1")
                {
                    Caption = 'Grant Code 1';
                }
                // field(otherLeadSource; Rec."Other Lead Source")
                // {
                //     Caption = 'Other Lead Source';
                // }

                // field(studentGroup; Rec."Student Group")
                // {
                //     Caption = 'Student On-Ground Group';
                // }
                field(estimatedGraduationDate; Rec."Estimated Graduation Date")
                {
                    Caption = 'Estimated Graduation Date';
                }
                field(separationDate; Rec."Separation Date")
                {
                    Caption = 'Separation Date';
                }
                field(dateCleared; Rec."Date Cleared")
                {
                    Caption = 'Date Cleared';
                }
                field(dateAwarded; Rec."Date Awarded")
                {
                    Caption = 'Date Awarded';
                }
                field(grantCode2; Rec."Grant Code 2")
                {
                    Caption = 'Grant Code 2';
                }
                field(fafsaType; Rec."FAFSA Type")
                {
                    Caption = 'FAFSA Type';
                }
                field(graduationDate; Rec."Graduation Date")
                {
                    Caption = 'Graduation Date';
                }
                field(dateOfDetermination; Rec."Date Of Determination")
                {
                    Caption = 'Date of Determination';
                }
                field(lastDateOfAttendance; Rec."Last Date Of Attendance")
                {
                    Caption = 'Last Date Of Attendance';
                }
                field(dismissalDate; Rec."Dismissal Date")
                {
                    Caption = 'Dismissal Date';
                }
                field(nationalityDescription; Rec."Nationality Description")
                {
                    Caption = 'Nationality Description';
                }
                field(overallGPA; Rec."Overall GPA")
                {
                    Caption = 'Overall GPA';
                }
                field(basicScienceGPA; Rec."Basic Science GPA")
                {
                    Caption = 'Basic Science GPA';
                }
                field(clinicalGPA; Rec."Clinical GPA")
                {
                    Caption = 'Clinical GPA';
                }
                field(instituteName; Rec."Institute Name")
                {
                    Caption = 'Institute Name';
                }
                // field(expectedGradeDate; Rec.ExpectedGradeDate)
                // {
                //     Caption = 'Expected Graduation Date';
                // }
                // field(clnUsmleCertificationDate; Rec.ClnUsmleCertificationDate)
                // {
                //     Caption = 'USMLE Certification Date';
                // }
                // field(qbStudentID; Rec.QBStudentID)
                // {
                //     Caption = 'QB Student ID';
                // }
                // field(tsStudentEID; Rec.TSStudentEID)
                // {
                //     Caption = 'TS Student EID';
                // }
                // field(studentAltKey; Rec.StudentAltKey)
                // {
                //     Caption = 'Student Alt Key';
                // }
                // field(aamcID; Rec.AamcID)
                // {
                //     Caption = 'Aamc ID';
                // }
                // field(usmleID; Rec.UsmleID)
                // {
                //     Caption = 'USMLE ID';
                // }
                // field(usmleRefCode; Rec.UsmleRefCode)
                // {
                //     Caption = 'USMLE Ref Code';
                // }
                // field(usmleCertDate; Rec.UsmleCertDate)
                // {
                //     Caption = 'USMLE Cert Date';
                // }
                // field(usmleCertTranscriptDate; Rec.UsmleCertTranscriptDate)
                // {
                //     Caption = 'USMLE Cert Transcript Date';
                // }
                // field(ecfmgCertDate; Rec.EcfmgCertDate)
                // {
                //     Caption = 'Ecfmg Cert Date';
                // }
                // field(clinicalCurriculum; Rec."Clinical Curriculum")
                // {
                //     Caption = 'Clinical Curriculum';
                // }
                // field(studentPassportIssuedBy; Rec.StudentPassportIssuedBy)
                // {
                //     Caption = 'Student Passport Issued By';
                // }
                // field(countryOfCitizenship; Rec.CountryOfCitizenship)
                // {
                //     Caption = 'Country of Citizenship';
                // }
                // field(remoteLearningChoice; Rec."Remote Learning Choice")
                // {
                //     Caption = 'Remote Learning Choice';
                // }
                // field(cln5ThSemEnded; Rec.Cln5thSemEnded)
                // {
                //     Caption = '5th Sem Ended';
                // }
                field(intentToPay; Rec."Intent to Pay")
                {
                    Caption = 'Intent to Pay';
                }
                field(vaBenefit; Rec."VA Benefit")
                {
                    Caption = 'VA Benefit';
                }
                field(calcSemesterIGPA; Rec."Calc. Semester I GPA")
                {
                    Caption = 'Calc. Semester I GPA';
                }
                field(calcSemesterIIGPA; Rec."Calc. Semester II GPA")
                {
                    Caption = 'Calc. Semester II GPA';
                }
                field(calcSemesterIIIGPA; Rec."Calc. Semester III GPA")
                {
                    Caption = 'Calc. Semester III GPA';
                }
                field(calcSemesterIVGPA; Rec."Calc. Semester IV GPA")
                {
                    Caption = 'Calc. Semester IV GPA';
                }
                field(calcSemesterVGPA; Rec."Calc. Semester V GPA")
                {
                    Caption = 'Calc. Semester V GPA';
                }
                field(calcSemesterVIGPA; Rec."Calc. Semester VI GPA")
                {
                    Caption = 'Calc. Semester VI GPA';
                }
                field(calcSemesterVIIGPA; Rec."Calc. Semester VII GPA")
                {
                    Caption = 'Calc. Semester VII GPA';
                }
                field(calcSemesterVIIIGPA; Rec."Calc. Semester VIII GPA")
                {
                    Caption = 'Calc. Semester VIII GPA';
                }
                field(calcSemesterIXGPA; Rec."Calc. Semester IX GPA")
                {
                    Caption = 'Calc. Semester IX GPA';
                }
                field(calcGPA; Rec."Calc. GPA")
                {
                    Caption = 'Calc. GPA';
                }
                field(grantCode3; Rec."Grant Code 3")
                {
                    Caption = 'Grant Code 3';
                }
                field(appliedForScholarship; Rec."Applied For Scholarship")
                {
                    Caption = 'Applied For Scholarship';
                }
                field(approvedForScholarship; Rec."Approved For Scholarship")
                {
                    Caption = 'Approved For Scholarship';
                }
                field(fsaID; Rec."FSA ID")
                {
                    Caption = 'FSA ID';
                }
                field(t4Authorization; Rec."T4 Authorization")
                {
                    Caption = 'T4 Authorization';
                }
                // field(creationDate; Rec."Creation Date")
                // {
                //     Caption = 'Creation Date';
                // }
                // field(createdBy; Rec."Created By")
                // {
                //     Caption = 'Created By';
                // }
                field(applyForInsurance; Rec."Apply For Insurance")
                {
                    Caption = 'Apply For Insurance';
                }
                field(ecfmgID; Rec."ECFMG ID")
                {
                    Caption = 'ECFMG ID';
                }
                field(kmcID; Rec."KMC ID")
                {
                    Caption = 'KMC ID';
                }

                field(ferpaRelease; Rec."FERPA Release")
                {
                    Caption = 'FERPA Release';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }

                field(originalStartDate; Rec."Original Start Date")
                {
                    Caption = 'Original Start Date';
                }
                field(originalExpStartDate; Rec."Original Exp. Start Date")
                {
                    Caption = 'Original Exp. Start Date';
                }
                field(applicationReceivedDate; Rec."Application Received Date")
                {
                    Caption = 'Application Received Date';
                }
                field(reEntryDate; Rec."Re-Entry Date")
                {
                    Caption = 'Re-Entry Date';
                }
                field(midDate; Rec."Mid Date")
                {
                    Caption = 'Mid Date';
                }
                field(lda; Rec.LDA)
                {
                    Caption = 'LDA';
                }
                field(statusDate; Rec."Status Date")
                {
                    Caption = 'Status Date';
                }
                field(gradeLevelDescription; Rec."Grade Level Description")
                {
                    Caption = 'Grade Level Description';
                }
                field(transferInDate; Rec."Transfer In Date")
                {
                    Caption = 'Transfer In Date';
                }
                field(sap; Rec.SAP)
                {
                    Caption = 'SAP';
                }
                field(nsldsWithdrawalDate; Rec."NSLDS Withdrawal Date")
                {
                    Caption = 'NSLDS Withdrawal Date';
                }

                field(upDatedoN; Rec."Updated On")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}