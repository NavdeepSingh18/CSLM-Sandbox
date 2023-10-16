codeunit 50003 "CSLMVerticalEducation-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   19/02/2019     CreateSessionYear()-Function           Code added for create session year.
    // 02    CSPL-00059   19/02/2019     CreateAdmissionYr()-Function           Code added for create admission year .
    // 03    CSPL-00059   19/02/2019     CreateAdmission_Yr()-Function          Code added for create admission_year.
    // 04    CSPL-00059   19/02/2019     RankCreation()-Function                Code added for rank creation.
    // 05    CSPL-00059   19/02/2019     CloseSession_Year()-Function           Code added for close session year.
    // 06    CSPL-00059   19/02/2019     OpenSession_Year()-Function            Code added for open session year.
    // 07    CSPL-00059   19/02/2019     GradesCopy()-Function                  Code added for grades copy.
    // 08    CSPL-00059   19/02/2019     ResetAcademicYr()-Function             Code added for reset academic year.


    trigger OnRun()
    begin
    end;

    var
        EducationSetupCS: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        AcademicsStageCS: Codeunit "Academics Stage-CS";
        Text000Lbl: Label 'Academic Year Already Closed';
        Text002Lbl: Label 'Academic Year Has Been Assigned';
        Text003Lbl: Label 'Do you want to Close the academic Year ?';
        Text004Lbl: Label 'Do you want to Assign the academic Year ?';
        Text005Lbl: Label 'Do you want to Reset the academic Year ?';

    procedure CreateSessionYear(): Code[20]

    begin
        //Code added for create session year::CSPL-00059::19022019: Start
        UserSetupRec.Get(UserId());
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            EducationSetupCS.TESTFIELD("Academic Year");
            EXIT(EducationSetupCS."Academic Year")
        end;
        //Code added for create session year::CSPL-00059::19022019: End
    end;

    procedure CreateAdmissionYr(): Code[10]
    var
        AdmissionSetupCS: Record "Admission Setup-CS";
    begin
        //Code added for create admission year::CSPL-00059::19022019: Start
        AdmissionSetupCS.Get();
        AdmissionSetupCS.TESTFIELD("Admission Year");
        EXIT(AdmissionSetupCS."Admission Year");
        //Code added for create admission year::CSPL-00059::19022019: End
    end;

    procedure CreateAdmission_Yr(): Code[10]
    var
        AdmissionSetupCS: Record "Admission Setup-CS";
    begin
        //Code added for create admission year::CSPL-00059::19022019: Start
        AdmissionSetupCS.GET();
        //AdmissionSetupCS.TESTFIELD("Admission Year");
        EXIT(AdmissionSetupCS."Admission Year");
        //Code added for create admission year::CSPL-00059::19022019: End
    end;

    procedure RankCreation("getFirstNo.": Code[20]; "getLastNo.": Code[20])
    var

    begin
        //Code added for Rank Creation::CSPL-00059::19022019: Start
        /*
        SetRank := 1;
        StudentTeacherGuardianCS.Reset();
        StudentTeacherGuardianCS.SETRANGE("Entry No.","getFirstNo.","getLastNo.");
        StudentTeacherGuardianCS.MODIFYALL(Rank,0);
        
        StudentTeacherGuardianCS.Reset();
        StudentTeacherGuardianCS.SETCURRENTKEY(Average);
        StudentTeacherGuardianCS.SETRANGE("Entry No.","getFirstNo.","getLastNo.");
        StudentTeacherGuardianCS.ASCENDING(FALSE);
        IF StudentTeacherGuardianCS.FINDFIRST()THEN
          REPEAT
            StudentTeacherGuardianCS1.Reset();
            StudentTeacherGuardianCS1.SETRANGE("Entry No.","getFirstNo.","getLastNo.");
            StudentTeacherGuardianCS1.SETRANGE(Average,StudentTeacherGuardianCS.Average);
            StudentTeacherGuardianCS1.SETRANGE(Rank,0);
            Countrank := StudentTeacherGuardianCS1.COUNT ;
            StudentTeacherGuardianCS1.MODIFYALL(Rank,SetRank);
            IF Countrank <> 0 THEN
              SetRank := Countrank + SetRank;
          UNTIL StudentTeacherGuardianCS.NEXT() = 0;
        
         */
        //Code added for Rank Creation::CSPL-00059::19022019: End

    end;

    procedure CloseSession_Year(AcaYear: Code[10])
    var
        AcademicYearMasterCS: Record "Academic Year Master-CS";
    begin
        //Code added for close session year::CSPL-00059::19022019: Start
        IF CONFIRM(Text003Lbl) THEN BEGIN
            AcademicYearMasterCS.GET(AcaYear);
            AcademicYearMasterCS.Closed := TRUE;
            AcademicYearMasterCS.Modify();
        END;
        //Code added for close session year::CSPL-00059::19022019: End
    end;

    procedure OpenSession_Year(AcademicCode: Code[20])
    var
        AcademicYearMasterCS: Record "Academic Year Master-CS";

    begin
        //Code added for open session year::CSPL-00059::19022019: Start
        AcademicYearMasterCS.GET(AcademicCode);
        IF AcademicYearMasterCS.Closed THEN
            ERROR(Text000Lbl);

        IF CONFIRM(Text004Lbl) THEN BEGIN
            UserSetupRec.Get(UserId());
            EducationSetupCS.Reset();
            EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            If EducationSetupCS.FindFirst() Then begin
                EducationSetupCS."Academic Year" := AcademicYearMasterCS.Code;
                EducationSetupCS."Start Date" := AcademicYearMasterCS."Start Date";
                EducationSetupCS."End Date" := AcademicYearMasterCS."End Date";
                EducationSetupCS.Modify();
                MESSAGE(Text002Lbl);
            end;
        END;
        //Code added for open session year::CSPL-00059::19022019: End
    end;

    procedure GradesCopy()
    begin
        //Code added for update grdes ::CSPL-00059::19022019: Start
        UserSetupRec.Get(UserId());
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            EducationSetupCS.TESTFIELD(Company);
            IF EducationSetupCS.Company = EducationSetupCS.Company::College THEN
                AcademicsStageCS.CopyGradesCreate();
            //Code added for update grdes::CSPL-00059::19022019: End
        end;
    end;

    procedure ResetAcademicYr(AcademicCode: Code[10])
    var
        AcademicYearMasterCS: Record "Academic Year Master-CS";
    begin
        //Code added for reset academic year ::CSPL-00059::19022019: Start
        IF CONFIRM(Text005Lbl) THEN BEGIN
            AcademicYearMasterCS.GET(AcademicCode);
            AcademicYearMasterCS.Closed := FALSE;
            AcademicYearMasterCS.Modify();
        END;
        //Code added for reset academic year::CSPL-00059::19022019: End
    end;
}

