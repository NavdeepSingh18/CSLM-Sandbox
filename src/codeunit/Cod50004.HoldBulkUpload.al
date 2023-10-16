codeunit 50004 "Hold Bulk Upload"
{
    Permissions = tabledata 50381 = rimd, tabledata 50363 = rimd, tabledata 50334 = rimd, tabledata 50478 = rimd, tabledata 50481 = rimd, tabledata 50365 = rimd, tabledata 50197 = rimd, tabledata 21 = rimd, tabledata 379 = rimd, tabledata 17 = rimd, tabledata 271 = rimd, tabledata 50462 = rimd, tabledata 50353 = rimd, tabledata 50453 = rimd, tabledata 50404 = rimd, tabledata 50030 = rimd,
    tabledata 50113 = rimd, tabledata 50437 = rimd, tabledata 50385 = rimd, tabledata 50077 = rimd, tabledata 50463 = rimd, tabledata 50028 = rimd, tabledata 50057 = rimd;
    trigger OnRun()
    begin
    end;

    //NewStudent to Deposited Student AICASA AUA Start >>>>>
    procedure NewStudenttoDesposited(GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
    begin
        StatusRec.Reset();
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        StatusRec.SetRange(Status, StatusRec.Status::Deposited);
        StatusRec.findfirst();
        NewStatus := StatusRec.Code;
    end;

    //NewStudent to Deposited Student AICASA AUA End <<<<<

    //Deposited to Deffered Declined Student AICASA AUA Start >>>>>
    procedure DepositedtoDefferedDeclined(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]; DefDecStatus: text[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Deposited for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        if StatusType = StatusType::Deposited then begin

            if DefDecStatus = 'Declined' then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Declined);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;

            if DefDecStatus = 'Deferred' then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Deferred);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
        end else
            error(Text001Lbl, StudentNo);
    end;

    //Deposited to Deffered Declined Student AICASA AUA End <<<<<

    //Deffered to Declined Student AICASA AUA Start >>>>>
    procedure DefferedtoDeclined(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Deferred for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        if StatusType = StatusType::Deferred then begin

            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Declined);
            StatusRec1.findfirst();
            NewStatus := StatusRec1.Code;
        end else
            error(Text001Lbl, StudentNo);
    end;

    //Deffered to Declined Student AICASA AUA End <<<<<

    //Declined to Deposited Student AICASA AUA Start >>>>>
    procedure DeclinedtoDeposited(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Declined for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        if StatusType = StatusType::Declined then begin

            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Deposited);
            StatusRec1.findfirst();
            NewStatus := StatusRec1.Code;
        end else
            error(Text001Lbl, StudentNo);

    end;

    //Declined to Deposited Student AICASA AUA End <<<<<

    //Declined to Deferred Student AICASA AUA Start >>>>>
    procedure DeclinedtoDeferred(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Declined for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        if StatusType = StatusType::Declined then begin

            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Deferred);
            StatusRec1.findfirst();
            NewStatus := StatusRec1.Code;
        end else
            error(Text001Lbl, StudentNo);

    end;

    //Declined to Deferred Student AICASA AUA End <<<<<

    //New Deferred Student Online Registration AICASA AUA Start >>>>>
    procedure NewDeferredStudentOnlineRegistration(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Deposited or Deferred for Student No. %1';
    begin
        //  if GD1 = '9000' then begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        if ((StatusType = StatusType::Deposited) Or (StatusType = StatusType::Deferred)) then begin

            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::ROL);
            StatusRec1.findfirst();
            NewStatus := StatusRec1.Code;
        end else
            error(Text001Lbl, StudentNo);
        //end;

        // if GD1 = '9100' then begin
        //     StatusRec.Reset();
        //     StatusRec.SetRange(code, OldStatus);
        //     StatusRec.SetRange("Global Dimension 1 Code", GD1);
        //     if StatusRec.findfirst() then
        //         StatusType := StatusRec.status;
        //     if ((StatusType = StatusType::Deposited) Or (StatusType = StatusType::Deferred)) then begin

        //         StatusRec1.Reset();
        //         StatusRec1.SetRange("Global Dimension 1 Code", GD1);
        //         StatusRec1.SetRange(Status, StatusRec1.Status::Enrolled);
        //         StatusRec1.findfirst();
        //         NewStatus := StatusRec1.Code;
        //     end else
        //         error(Text001Lbl, StudentNo);
        // end;

    end;

    procedure NewDeferredStudentOnlineRegistration1(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Deposited or Deferred for Student No. %1';
    begin
        //  if GD1 = '9000' then begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        // if ((StatusType = StatusType::Deposited) Or (StatusType = StatusType::Deferred)) then begin

        StatusRec1.Reset();
        StatusRec1.SetRange("Global Dimension 1 Code", GD1);
        StatusRec1.SetRange(Status, StatusRec1.Status::ROL);
        StatusRec1.findfirst();
        NewStatus := StatusRec1.Code;
        // end else
        //     error(Text001Lbl, StudentNo);
        //end;

        // if GD1 = '9100' then begin
        //     StatusRec.Reset();
        //     StatusRec.SetRange(code, OldStatus);
        //     StatusRec.SetRange("Global Dimension 1 Code", GD1);
        //     if StatusRec.findfirst() then
        //         StatusType := StatusRec.status;
        //     if ((StatusType = StatusType::Deposited) Or (StatusType = StatusType::Deferred)) then begin

        //         StatusRec1.Reset();
        //         StatusRec1.SetRange("Global Dimension 1 Code", GD1);
        //         StatusRec1.SetRange(Status, StatusRec1.Status::Enrolled);
        //         StatusRec1.findfirst();
        //         NewStatus := StatusRec1.Code;
        //     end else
        //         error(Text001Lbl, StudentNo);
        // end;

    end;

    //New Deferred Student Online Registration AICASA AUA End <<<<<

    //Registrar Signoff AICASA AUA Page 50295 Start >>>>>
    procedure RegistrarSignoff(StudentNo: Code[20]; OldStatus: Code[20]; Sem: Code[10]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        SemesterRec: Record "Semester Master-CS";
        SemesterSequence: Integer;
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
    //  Text001Lbl: Label 'Student Status must be ROL for Student No. %1';
    //  Text002Lbl: Label 'Student Status must be Enrolled for Student No. %1';
    begin
        if GD1 = '9000' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            StatusRec.findfirst();
            StatusType := StatusRec.status;

            SemesterSequence := 0;
            SemesterRec.Reset();
            SemesterRec.SetRange(Code, Sem);
            IF SemesterRec.FindFirst() then
                SemesterSequence := SemesterRec.Sequence;

            if (StatusType = StatusType::ROL) AND (SemesterSequence <> 5) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;

            if (StatusType = StatusType::Enrolled) AND (SemesterSequence = 5) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
        end;

        if GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            StatusRec.findfirst();
            StatusType := StatusRec.status;

            if (StatusType = StatusType::ROL) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
        end;
    end;

    //Registrar Signoff AICASA AUA Page 50295 End <<<<<

    //SLOA ELOA CLOA AICASA AUA Start >>>>>
    procedure SLOAELOACLOASignoff(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20];
    ApplicationType: Option ELOA,SLOA,CLOA) NewStatus: Code[20]
    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        if (StatusType = StatusType::TWD) or (StatusType = StatusType::Active) or (StatusType = StatusType::Probation) then begin
            if ApplicationType = ApplicationType::ELOA then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::ELOA);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
            if ApplicationType = ApplicationType::SLOA then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::SLOA);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
            if ApplicationType = ApplicationType::CLOA then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::CLOA);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;
        end else
            Error(Text001Lbl, StudentNo);
    end;

    //SLOA ELOA AICASA AUA End <<<<<

    //Withdrawal Signoff AICASA AUA Start >>>>>
    procedure WithdwaralSignoff(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]
    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
    //  Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;
        // if (StatusType = StatusType::Active) or (StatusType = StatusType::Probation) then begin
        StatusRec1.Reset();
        StatusRec1.SetRange("Global Dimension 1 Code", GD1);
        StatusRec1.SetRange(Status, StatusRec1.Status::Withdrawn);
        StatusRec1.findfirst();
        NewStatus := StatusRec1.Code;
        //  end else
        //      Error(Text001Lbl, StudentNo);
    end;

    //Withdrawal Signoff AICASA AUA End <<<<<

    //Returning Student Online Registration AUA Start >>>>>
    procedure ReturningStudentOnlineRegistrationAUA(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Enrolled or Re-Entry or Re-Admitted or ELOA for Student No. %1';
    begin
        IF GD1 = '9000' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            If StatusType IN [StatusType::Enrolled, StatusType::"Re-Entry", StatusType::"Re-Admitted", StatusType::ELOA] then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::ROL);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Returning Student Online Registration AUA End <<<<<

    //Returning Student Online Registration AICASA Start >>>>> Not Required
    procedure ReturningStudentOnlineRegistrationAICASA(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Enrolled or Re-Entry or Re-Admitted or ELOA for Student No. %1';
    begin
        If GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            IF StatusType In [StatusType::Enrolled, StatusType::"Re-Entry", StatusType::"Re-Admitted", StatusType::ELOA] then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Enrolled);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Returning Student Online Registration AICASA End <<<<<

    //Probation Returning Student Online Registration AICASA Start >>>>>
    procedure ProbationReturningStudentOnlineRegistrationAICASA(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]
    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Probation for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        if StatusType = StatusType::Probation then begin
            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Probation);
            StatusRec1.FindFirst();
            NewStatus := StatusRec1.Code;
        end ELSE
            error(Text001Lbl, StudentNo);
    end;

    ///Probation Returning Student Online Registration AICASA End <<<<<

    //Re-Entry Student AICASA AUA Start >>>>>
    procedure ReEntryStudent(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Dismissed for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        if StatusType = StatusType::Dismissed then begin
            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::"Re-Entry");
            StatusRec1.FindFirst();
            NewStatus := StatusRec1.Code;
        end ELSE
            error(Text001Lbl, StudentNo);
    end;

    //Re-Entry Student AICASA AUA End <<<<<

    //Re-Admitted Student AICASA AUA Start >>>>>
    procedure ReAdmittedStudentOnlineRegistration(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Withdrawn for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        if StatusType = StatusType::Withdrawn then begin
            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::"Re-Admitted");
            StatusRec1.FindFirst();
            NewStatus := StatusRec1.Code;
        end ELSE
            error(Text001Lbl, StudentNo);
    end;

    //Re-Admitted Student AICASA AUA End <<<<<

    //Student Graduated AICASA Start >>>>>
    procedure StudentGraduatedAICASA(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD,"Pending Graduation";
        Text001Lbl: Label 'Student Status must be Promoted or Compeleted for Student No. %1';
    begin
        //If GD1 = '9100' then begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        IF StatusType IN [StatusType::Promoted, StatusType::Compeleted] then begin
            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Graduated);
            StatusRec1.FindFirst();
            NewStatus := StatusRec1.Code;
        end ELSE
            Error(Text001Lbl, StudentNo);
        //end;
    end;

    //Student Graduated AICASA End <<<<<

    //Student Promotion AICASA Start >>>>>
    procedure StudentPromotionAICASA(StudentNo: Code[20]; OldStatus: Code[20]; Sem: Code[10]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        SemesterMasterRec: Record "Semester Master-CS";
        SemesterSequence: Integer;
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin

        IF GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            SemesterSequence := 0;
            SemesterMasterRec.RESET();
            SemesterMasterRec.SetRange(Code, Sem);
            IF SemesterMasterRec.FindFirst() then
                SemesterSequence := SemesterMasterRec.Sequence;

            IF (StatusType In [StatusType::Active, StatusType::Probation]) and (SemesterSequence = 4) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Promoted);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSe
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Student Promotion AICASA End <<<<<

    //Student Semester Promotion AICASA AUA Start >>>>>
    procedure StudentSemPromotion(StudentNo: Code[20]; OldStatus: Code[20]; Sem: Code[10]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active for Student No. %1';
    begin
        IF GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            if (StatusType = StatusType::Active) then begin

                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Enrolled);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
        IF GD1 = '9000' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            if (StatusType = StatusType::Active) then begin

                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Enrolled);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Student Semester Promotion AICASA End <<<<<

    //Student Semester Compeleted AICASA Start >>>>>
    procedure StudentSemCompeletedAICASA(StudentNo: Code[20]; OldStatus: Code[20]; Sem: Code[10]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        SemesterMasterRec: Record "Semester Master-CS";
        SemesterSequence: Integer;
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin

        IF GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            SemesterSequence := 0;
            SemesterMasterRec.Reset();
            SemesterMasterRec.SetRange(Code, Sem);
            If SemesterMasterRec.FindFirst() then
                SemesterSequence := SemesterMasterRec.Sequence;

            IF (StatusType IN [StatusType::Active, StatusType::Probation]) and (SemesterSequence = 4) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Compeleted);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Student Semester Compeleted AICASA End <<<<<

    //Student Dismissed AICASA Start >>>>>
    procedure StudentDismissedAICASA(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin
        IF GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            IF StatusType In [StatusType::Active, StatusType::Probation] then begin

                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Dismissed);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);
        end;
    end;

    //Student Dismissed AICASA End <<<<<

    //Student Deceased AICASA AUA Start >>>>>
    procedure StudentDeceased(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Active or Probation for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        IF StatusType In [StatusType::Active, StatusType::Probation] then begin
            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Deceased);
            StatusRec1.FindFirst();
            NewStatus := StatusRec1.Code;
        end Else
            Error(Text001Lbl, StudentNo);
    end;

    //Student Deceased AICASA AUA End <<<<<

    //Student Administratively Withdrawn AICASA AUA BSIC Start >>>>>
    procedure StudentAdministrativelyWithdrawn(StudentNo: Code[20]; OldStatus: Code[20]; Sem: Code[10]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        SemesterMasterRec: Record "Semester Master-CS";
        SemesterSequence: Integer;
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Enrolled or Re-Entry or Re-Admitted or ELOA or Probation for Student No. %1';
        Text002Lbl: Label 'Student Status must be Enrolled or ELOA or Probation for Student No. %1';
    begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        SemesterSequence := 0;
        SemesterMasterRec.Reset();
        SemesterMasterRec.SetRange(Code, Sem);
        If SemesterMasterRec.FindFirst() then
            SemesterSequence := SemesterMasterRec.Sequence;

        IF GD1 = '9000' then begin
            IF (StatusType In [StatusType::Enrolled, StatusType::"Re-Entry", StatusType::"Re-Admitted", StatusType::ELOA]) and (SemesterSequence <> 5) then begin

                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::ADWD);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end Else
                Error(Text001Lbl, StudentNo);

            IF (StatusType in [StatusType::Enrolled, StatusType::ELOA, StatusType::Probation]) and (SemesterSequence = 5) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::ADWD);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text002Lbl, StudentNo);
        end;

        IF GD1 = '9100' then begin
            IF StatusType IN [StatusType::Enrolled, StatusType::"Re-Entry", StatusType::"Re-Admitted", StatusType::ELOA, StatusType::Probation] then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::ADWD);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end;
        end;

    end;

    //Student Administratively Withdrawn AICASA AUA End <<<<<

    //Student From Suspension to Active AUA BSIC Start >>>>>
    procedure StudentSuspensiontoActiveAUABSIC(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
        Text001Lbl: Label 'Student Status must be Susoension for Student No. %1';
    begin
        IF GD1 = '9000' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            if StatusRec.findfirst() then
                StatusType := StatusRec.status;

            if (StatusType = StatusType::Suspension) then begin

                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.FindFirst();
                NewStatus := StatusRec1.Code;
            end ELSE
                Error(Text001Lbl, StudentNo);

        end;
    end;

    //Student From Suspension to Active AUA BSIC End <<<<<

    procedure EnableStudentWiseHold(Stud: Record "Student Master-CS");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if not StudentHoldRec.findfirst() then
            error('Data not found in Student Hold List');

        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", Stud."No.");
        StudentWiseHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        If StudentWiseHoldRec.FindSet() then
            StudentWiseHoldRec.DeleteAll();

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetFilter(StudentHoldRec."Hold Type", '<>%1&<>%2&<>%3&<>%4', StudentHoldRec."Hold Type"::Registrar, StudentHoldRec."Hold Type"::"Registrar Sign-off", StudentHoldRec."Hold Type"::Immigration, StudentHoldRec."Hold Type"::" ");
        if StudentHoldRec.findfirst() then
            repeat
                StudentWiseHoldRec.Reset();
                StudentWiseHoldRec.SetRange("Student No.", Stud."No.");
                StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                StudentWiseHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                if not StudentWiseHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Init();
                    StudentWiseHoldRec.Validate("Student No.", Stud."No.");
                    StudentWiseHoldRec."Student Name" := Stud."Student Name";
                    StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                    StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                    StudentWiseHoldRec.Semester := Stud.Semester;

                    //if (StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::Registrar)
                    //or (StudentHoldRec."Hold Type" = StudentHoldRec."Hold Type"::"Registrar Sign-off") then
                    //    StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable
                    //else

                    StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                    StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                    StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                    StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                    StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                    StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                    StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                    StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                    StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                    StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                    StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    StudentWiseHoldRec."Created By" := format(UserId());
                    StudentWiseHoldRec."Created On" := Today();
                    StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Insert();
                end;

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger."Student No." := Stud."No.";
                RecHoldStatusLedger."Student Name" := Stud."Student Name";
                RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                RecHoldStatusLedger.Semester := Stud.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                RecHoldStatusLedger.Insert();
            Until StudentHoldRec.NEXT() = 0;
    end;

    procedure EnableAllHold(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.Setrange("Student No.", Stud."No.");
            // StudentWiseHoldRec.Setrange("Academic Year", Stud."Academic Year");
            // StudentWiseHoldRec.Setrange(Semester, Stud.Semester);
            StudentWiseHoldRec.SetRange("Hold Type", HoldType);
            if not StudentWiseHoldRec.FindFirst() then begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", Stud."No.");
                StudentWiseHoldRec."Student Name" := Stud."Student Name";
                StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                StudentWiseHoldRec.Semester := Stud.Semester;

                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                StudentWiseHoldRec.Insert();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger."Student No." := Stud."No.";
                RecHoldStatusLedger."Student Name" := Stud."Student Name";
                RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                RecHoldStatusLedger.Semester := Stud.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                RecHoldStatusLedger.Insert();
            end else begin
                if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Disable then begin
                    StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                    StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Modify();

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := Stud."No.";
                    RecHoldStatusLedger."Student Name" := Stud."Student Name";
                    RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                    RecHoldStatusLedger.Semester := Stud.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                    RecHoldStatusLedger.Insert();
                end else
                    Error('The %1 hold is already enabled.', StudentHoldRec."Hold Type");
            end;
        end else
            error('There is no data with in the filter.');
    end;

    procedure EnableRegistrarHold(Stud: Record "Student Master-CS");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", StudentHoldRec."Hold Type"::Registrar);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Init();
            StudentWiseHoldRec.Validate("Student No.", Stud."No.");
            StudentWiseHoldRec."Student Name" := Stud."Student Name";
            StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
            StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
            StudentWiseHoldRec.Semester := Stud.Semester;

            StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
            StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
            StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
            StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
            StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
            StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
            StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
            StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
            StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
            StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
            StudentWiseHoldRec.Insert();

            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo;
            RecHoldStatusLedger."Student No." := Stud."No.";
            RecHoldStatusLedger."Student Name" := Stud."Student Name";
            RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
            RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
            RecHoldStatusLedger.Semester := Stud.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
            RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
            RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
            RecHoldStatusLedger.Insert();
        end else
            error('There is no data with in the filter.');
    end;

    procedure DisableRegistrarHold(Stud: Record "Student Master-CS");
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", Stud."No.");
        StudentWiseHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Registrar);
        If StudentWiseHoldRec.FindSet() then begin

            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo;
            RecHoldStatusLedger."Student No." := Stud."No.";
            RecHoldStatusLedger."Student Name" := Stud."Student Name";
            RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
            RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
            RecHoldStatusLedger.Semester := Stud.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Registrar;
            RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
            RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
            RecHoldStatusLedger.Insert();

            StudentWiseHoldRec.DeleteAll(true);
        end else
            Error('There is no data with in the filter');
    end;

    //Student Graduation AUA Start >>>>>
    procedure StudentGraduated(StudentNo: Code[20]; OldStatus: Code[20]; GD1: Code[20]) NewStatus: Code[20]

    var
        StatusRec: Record "Student Status";
        StatusRec1: Record "Student Status";
        StatusType: Option " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD,"Pending Graduation";
        Text001Lbl: Label 'Student Status must be Pending Graduation for Student No. %1';
    begin
        //  if GD1 = '9100' then begin
        StatusRec.Reset();
        StatusRec.SetRange(code, OldStatus);
        StatusRec.SetRange("Global Dimension 1 Code", GD1);
        if StatusRec.findfirst() then
            StatusType := StatusRec.status;

        if (StatusType = StatusType::"Pending Graduation") then begin

            StatusRec1.Reset();
            StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            StatusRec1.SetRange(Status, StatusRec1.Status::Graduated);
            StatusRec1.findfirst();
            NewStatus := StatusRec1.Code;
        end else
            error(Text001Lbl, StudentNo);
        //end;

    end;

    //Student Graduation AUA End <<<<<

    //Student Group Restriction Code--Start >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    procedure StudentGroupWiseRestriction(StudentNo: Code[20]; RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold");
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
        Case RestrictionType of
            RestrictionType::"Registration Hold":
                begin
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'MissMCAT');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'AdmRescnd');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RegHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'BurHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'ClinHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'FAHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemER');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemFM');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemIM');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemOBGYN');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemPSY');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RemSUR');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RvsdCLOA');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RegDisRetest');
                    ErrorReturn();
                end;

            RestrictionType::"Transcript Hold":
                begin
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RegHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'BurHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'FAHold');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'ClnMissing');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RvsdCLOA');
                    ErrorReturn();
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'RegDisRetest');
                    ErrorReturn();
                end;
            RestrictionType::"Portal Schedule Hold":
                begin
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'ClinHold');
                    ErrorReturn();
                end;
            RestrictionType::"Disbursement Hold":
                begin
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'FAHold');
                    ErrorReturn();
                end;
            RestrictionType::"Housing Hold":
                begin
                    StudentWiseHoldRec.Setfilter("Group Code", '%1', 'HousingHold');
                    ErrorReturn();
                end;
        end;



    end;

    Local procedure ErrorReturn()
    begin
        if StudentWiseHoldRec.Findfirst() then
            Error('You cannot proceed as Student is on %1 Hold', StudentWiseHoldRec."Group Code");
    end;

    // procedure NewStudentCreated(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();



    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'SLcM System Administrator';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := Studentmaster."No." + ' ' + 'New Student Created';

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that a new student has been created in SLcM. Please refer to the below details:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Student ID :' + ' ' + Studentmaster."No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Student Name :' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Enrolment No. :' + ' ' + Studentmaster."Enrollment No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Course :' + ' ' + Studentmaster."Course Code");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('SLcM System Administrator');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //SMTPmail.send();
    // end;

    // procedure CommonLoanNotification(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //     BodyText: text[2048];

    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();

    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'Office of Student Financial Service';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Common Loan Notification';

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are writing to inform you that Free Application for Federal Student Aid (FAFSA) is now open for everyone.' +
    //                      'If you feel that you might require any help during studies, ' +
    //                      'then we would recommend you to please visit the federal government website and apply for Student Aid to avoid any financial obstructions during the studies.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please ignore above, if already applied for Federal Student Aid.');
    //     SmtpMail.AppendtoBody('<br><br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Office of Student Financial Service');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SMTPmail.send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Loan Notification', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Common Loan Notification', 'Common Loan Notification', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure AUAFinancialAidFormSubmission(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();



    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'SLcM System Administrator';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := Studentmaster."No." + ' ' + 'AUA Financial Aid Form Submission';

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are writing to inform you that ' + Studentmaster."No." + '-' + Studentmaster."Student Name" + ' has submitted the AUA Financial Aid Form. Kindly review and process it further.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thank you,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('SLcM System Administrator');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //SMTPmail.send();
    // end;

    // procedure FinancialAidHoldStatus(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];

    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'Office of Student Financial Service';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Financial Aid Hold Status';

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are happy to inform you that your Financial Aid Hold has been removed to ease the further registration process.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Office of Student Financial Service');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //SMTPmail.send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Financial Aid Hold', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'Financial Aid Hold Status', 'Financial Aid Hold Status', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure WithdrawalRequest(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     WithdrawalApprovals: Record "Withdrawal Approvals";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;

    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     WithdrawalApprovals.Reset();
    //     WithdrawalApprovals.SetRange("Student No.", StudentNo);
    //     WithdrawalApprovals.SetRange("Global Dimension 1 Code", '9000');
    //     if WithdrawalApprovals.FindFirst() then;
    //     SmtpMailRec.Get();

    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := Studentmaster."Student Name";
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := WithdrawalApprovals."AD ID" + ' ' + Studentmaster."No." + ' ' + Studentmaster."Student Name" + ' Withdrawal Request';

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that I would like to withdraw from ' + WithdrawalApprovals.Course + ' program, Semester ' + WithdrawalApprovals.Semester + ' due to ' + WithdrawalApprovals."Reason Code" + ' effective ' + format(WithdrawalApprovals."Application Date") + '.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Kindly approve my Withdrawal request.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody(Studentmaster."Student Name" + ' ' + Studentmaster."No." + ' ' + Studentmaster.Semester);
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //SMTPmail.send();
    // end;



    // procedure BroadcastEmailNotification(StudentNo: Code[20]; SubjectTxt: Text[250]; Body1: Text[2048]; Body2: Text[2048])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCS";
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[250];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := SubjectTxt;

    //     SmtpMail.Create(Recipients, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ' ' + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(Body1);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody(Body2);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(SenderName);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //SMTPmail.send();
    //     WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('BroadcastEmail', 'MEA', SenderAddress, Studentmaster."Student Name"
    //     , StudentNo, SubjectTxt, Body1, 'Broadcast', '', '', format(Today(), 0, 9), Studentmaster."E-Mail Address", 1, Studentmaster."Mobile Number", '', 0);
    // end;

    procedure OfficialTranscripts(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        RecMainStudentSubject.SetRange("Grade Confirmed", false);
        IF RecMainStudentSubject.FindFirst() then
            Message('Please Confirm all the Grades!');

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                MedicineOfficialTranscriptNew.RUNMODAL()
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                AICASAEMTTranscript.RUNMODAL()
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                StandardTranCreTranscript.RUNMODAL()
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                AUAMedicineMasterScienceReport.RUNMODAL()
            end;
        end;

    End;

    procedure UnOfficialTranscripts(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        RecMainStudentSubject.SetRange("Grade Confirmed", false);
        IF RecMainStudentSubject.FindFirst() then
            Message('Please Confirm all the Grades!');

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                MedicineOfficialTranscriptNew.RUNMODAL()
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                AICASAEMTTranscript.RUNMODAL()
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                StandardTranCreTranscript.RUNMODAL()
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                AUAMedicineMasterScienceReport.RUNMODAL()
            end;
        end;

    End;

    [EventSubscriber(ObjectType::Table, 50462, 'OnAfterInsertEvent', '', false, false)]
    local procedure StatusChangeInsert(var Rec: Record "Status Change Log entry"; RunTrigger: Boolean)
    begin
        InsertStatusChangeLogEntryLog(1, Rec);
    end;

    [EventSubscriber(ObjectType::Table, 50462, 'OnAfterModifyEvent', '', false, false)]
    local procedure StatusChangeModify(var Rec: Record "Status Change Log entry"; var xRec: Record "Status Change Log entry"; RunTrigger: Boolean)
    begin
        InsertStatusChangeLogEntryLog(2, Rec);
    end;

    [EventSubscriber(ObjectType::Table, 50462, 'OnAfterRenameEvent', '', false, false)]
    local procedure StatusChangeRename(var Rec: Record "Status Change Log entry"; var xRec: Record "Status Change Log entry"; RunTrigger: Boolean)
    begin
        InsertStatusChangeLogEntryLog(3, Rec);
    end;

    [EventSubscriber(ObjectType::Table, 50462, 'OnAfterDeleteEvent', '', false, false)]
    local procedure StatusChangeDelete(var Rec: Record "Status Change Log entry"; RunTrigger: Boolean)
    begin
        InsertStatusChangeLogEntryLog(4, Rec);
    end;

    procedure InsertStatusChangeLogEntryLog(LogType: Integer; StatusLog: Record "Status Change Log entry")
    var
        StatusChangeLogEntryLog: Record "Status Change Log Entry Log";
        NextLineNo: Integer;
    begin
        StatusChangeLogEntryLog.Reset();
        if StatusChangeLogEntryLog.FindLast() then;
        NextLineNo := StatusChangeLogEntryLog."Log Entry No." + 1;
        StatusChangeLogEntryLog.Reset();
        StatusChangeLogEntryLog.Init();
        StatusChangeLogEntryLog.TransferFields(StatusLog);
        StatusChangeLogEntryLog."Log Entry No." := NextLineNo;
        StatusChangeLogEntryLog."Log Type" := LogType;
        StatusChangeLogEntryLog."Log Entry Created By" := UserId();
        StatusChangeLogEntryLog."Log Entry Created On" := today();
        StatusChangeLogEntryLog.Insert(true);
    end;

    var
        StudentWiseHoldRec: Record "Student Wise Holds";

    //Student Group Restriction Code--End <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    procedure EnableAllHoldOLR(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentGroupRec: Record "Student Group";
        StudentTimelineREc: Record "Student Time Line";
        LGroup: Record Group;
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Hold Type", HoldType);
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if StudentHoldRec.FindFirst() then;
        LGroup.Reset();
        if LGroup.Get(StudentHoldRec."Group Code") then;
        // StudentGroupRec.Reset();
        // StudentGroupRec.SetRange("Student No.", Stud."No.");
        // StudentGroupRec.SetRange("Groups Code", StudentHoldRec."Group Code");
        // StudentGroupRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // if StudentGroupRec.findfirst() then
        //     Error('%1 Group Code is already present for Student No. %2 , Please check group manually.', StudentHoldRec."Group Code", Stud."No.");

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.Setrange("Student No.", Stud."No.");
            StudentWiseHoldRec.SetRange("Hold Type", HoldType);
            if not StudentWiseHoldRec.FindFirst() then begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", Stud."No.");
                StudentWiseHoldRec."Student Name" := Stud."Student Name";
                StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                StudentWiseHoldRec.Semester := Stud.Semester;

                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                StudentWiseHoldRec."Created By" := UserId();
                StudentWiseHoldRec."Created On" := Today();
                StudentWiseHoldRec.Inserted := true;
                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                StudentWiseHoldRec.Insert();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger."Student No." := Stud."No.";
                RecHoldStatusLedger."Student Name" := Stud."Student Name";
                RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                RecHoldStatusLedger.Semester := Stud.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                RecHoldStatusLedger.Insert();
            end else begin
                if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Disable then begin
                    StudentWiseHoldRec."Student Name" := Stud."Student Name";
                    StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                    StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                    StudentWiseHoldRec.Semester := Stud.Semester;
                    StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";

                    StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                    StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                    StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                    StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                    StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                    StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                    StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                    StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    StudentWiseHoldRec."Created By" := UserId();
                    StudentWiseHoldRec."Created On" := Today();
                    //StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                    StudentWiseHoldRec.Modify();

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := Stud."No.";
                    RecHoldStatusLedger."Student Name" := Stud."Student Name";
                    RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                    RecHoldStatusLedger.Semester := Stud.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                    RecHoldStatusLedger.Insert();
                end;// else
                    //Error('The %1 hold is already enabled.', StudentHoldRec."Hold Type");
                if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Enable then begin
                    StudentWiseHoldRec."Student Name" := Stud."Student Name";
                    StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                    StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                    StudentWiseHoldRec.Semester := Stud.Semester;
                    StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";

                    StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                    StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                    StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                    StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                    StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                    StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                    StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                    StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    StudentWiseHoldRec."Created By" := UserId();
                    StudentWiseHoldRec."Created On" := Today();
                    //StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                    StudentWiseHoldRec.Modify();

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := Stud."No.";
                    RecHoldStatusLedger."Student Name" := Stud."Student Name";
                    RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                    RecHoldStatusLedger.Semester := Stud.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                    RecHoldStatusLedger.Insert();
                end;
            end;

        end;// else
            //error('There is no data with in the filter.');

        //TimeLine Insert Added ==== 01-09-2021
        StudentTimelineREc.InsertRecordFun(Stud."No.", Stud."Student Name", Format(HoldType) + ' Hold has been Enabled', UserId(), Today());
        //TimeLine Insert Added ==== 01-09-2021
    end;

    procedure DisableAllHoldOLR(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentGroupRec: Record "Student Group";
        StudentTimeLineRec: Record "Student Time Line";
        LGroup: Record Group;
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Hold Type", HoldType);
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if StudentHoldRec.FindFirst() then;
        LGroup.Reset();
        if LGroup.Get(StudentHoldRec."Group Code") then;
        // StudentGroupRec.Reset();
        // StudentGroupRec.SetRange("Student No.", Stud."No.");
        // StudentGroupRec.SetRange("Groups Code", StudentHoldRec."Group Code");
        // StudentGroupRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // if not StudentGroupRec.findfirst() then
        //     Error('%1 Group Code is not present for Student No. %2 , Please check group manually.', StudentHoldRec."Group Code", Stud."No.");

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.Setrange("Student No.", Stud."No.");
            // StudentWiseHoldRec.Setrange("Academic Year", Stud."Academic Year");
            // StudentWiseHoldRec.Setrange(Semester, Stud.Semester);
            StudentWiseHoldRec.SetRange("Hold Type", HoldType);
            if StudentWiseHoldRec.FindFirst() then begin
                StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                StudentWiseHoldRec.Modify();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger."Student No." := Stud."No.";
                RecHoldStatusLedger."Student Name" := Stud."Student Name";
                RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                RecHoldStatusLedger.Semester := Stud.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                RecHoldStatusLedger.Insert();
            end;// else
                //Error('The %1 hold is already enabled.', StudentHoldRec."Hold Type");

        end;// else
            //error('There is no data with in the filter.');
            //Timeline Insert Added == 01-09-2021
        StudentTimeLineRec.InsertRecordFun(Stud."No.", Stud."Student Name", Format(HoldType) + ' Hold has been disabled', UserId(), Today());
        //timeline Insert Added == 01-09-2021
    end;

    procedure EnableAllHoldOLR1(Stud: Record "Student Master-CS"; OLRReturnStudentLine: Record "OLR Update Line"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.Setrange("Student No.", Stud."No.");
            // StudentWiseHoldRec.Setrange("Academic Year", OLRReturnStudentLine."OLR Academic Year");
            // StudentWiseHoldRec.Setrange(Semester, OLRReturnStudentLine."OLR Semester");
            StudentWiseHoldRec.SetRange("Hold Type", HoldType);
            if not StudentWiseHoldRec.FindFirst() then begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", Stud."No.");
                StudentWiseHoldRec."Student Name" := Stud."Student Name";
                StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
                StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
                StudentWiseHoldRec.Semester := Stud.Semester;

                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                StudentWiseHoldRec."Created By" := UserId();
                StudentWiseHoldRec."Created On" := Today();
                StudentWiseHoldRec.Inserted := true;
                StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                StudentWiseHoldRec.Insert();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger."Student No." := Stud."No.";
                RecHoldStatusLedger."Student Name" := Stud."Student Name";
                RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                RecHoldStatusLedger.Semester := Stud.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                RecHoldStatusLedger.Insert();
            end else begin
                if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Disable then begin
                    StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                    StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Modify();

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := Stud."No.";
                    RecHoldStatusLedger."Student Name" := Stud."Student Name";
                    RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
                    RecHoldStatusLedger.Semester := Stud.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                    RecHoldStatusLedger.Insert();
                end;// else
                    //Error('The %1 hold is already enabled.', StudentHoldRec."Hold Type");
            end;
        end;// else
            //error('There is no data with in the filter.');


    end;

    procedure EnableRegistrarBulkHold(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentGroupRec: Record "Student Group";
        LGroup: Record Group;
        LastNo: Integer;

    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Hold Type", HoldType);
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if StudentHoldRec.FindFirst() then;
        LGroup.Reset();
        if LGroup.Get(StudentHoldRec."Group Code") then;
        // StudentGroupRec.Reset();
        // StudentGroupRec.SetRange("Student No.", Stud."No.");
        // StudentGroupRec.SetRange("Groups Code", StudentHoldRec."Group Code");
        // StudentGroupRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // if StudentGroupRec.findfirst() then
        //     Error('%1 Group Code is present for Student No. %2 , Please check group manually.', StudentHoldRec."Group Code", Stud."No.");

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", StudentHoldRec."Hold Type"::Registrar);
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Init();
            StudentWiseHoldRec.Validate("Student No.", Stud."No.");
            StudentWiseHoldRec."Student Name" := Stud."Student Name";
            StudentWiseHoldRec."Academic Year" := Stud."Academic Year";
            StudentWiseHoldRec."Admitted Year" := Stud."Admitted Year";
            StudentWiseHoldRec.Semester := Stud.Semester;

            StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
            StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
            StudentWiseHoldRec."Group Code" := StudentHoldRec."Group Code";
            StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
            StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
            StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
            StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
            StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
            StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
            StudentWiseHoldRec.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            //StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
            StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
            StudentWiseHoldRec.Insert();

            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo;
            RecHoldStatusLedger."Student No." := Stud."No.";
            RecHoldStatusLedger."Student Name" := Stud."Student Name";
            RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
            RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
            RecHoldStatusLedger.Semester := Stud.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
            RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
            RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
            RecHoldStatusLedger.Insert();
        end;// else
            //error('There is no data with in the filter.');
    end;

    procedure DisableRegistrarBulkHold(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentGroupRec: Record "Student Group";
        StudentHoldRec: Record "Student Hold";
        LGroup: Record Group;
        LastNo: Integer;


    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Hold Type", HoldType);
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        if StudentHoldRec.FindFirst() then;
        LGroup.Reset();
        if LGroup.Get(StudentHoldRec."Group Code") then;
        // StudentGroupRec.Reset();
        // StudentGroupRec.SetRange("Student No.", Stud."No.");
        // StudentGroupRec.SetRange("Groups Code", StudentHoldRec."Group Code");
        // StudentGroupRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // if not StudentGroupRec.findfirst() then
        //     Error('%1 Group Code is not present for Student No. %2 , Please check group manually.', StudentHoldRec."Group Code", Stud."No.");

        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", Stud."No.");
        StudentWiseHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Registrar);
        If StudentWiseHoldRec.FindSet() then begin

            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo;
            RecHoldStatusLedger."Student No." := Stud."No.";
            RecHoldStatusLedger."Student Name" := Stud."Student Name";
            RecHoldStatusLedger."Academic Year" := Stud."Academic Year";
            RecHoldStatusLedger."Admitted Year" := Stud."Admitted Year";
            RecHoldStatusLedger.Semester := Stud.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := Stud."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := Stud."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Registrar;
            RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
            RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
            RecHoldStatusLedger.Insert();

            StudentWiseHoldRec.DeleteAll(true);
        end;//else
            //Error('There is no data with in the filter');
    end;

    procedure AssignStudentBulkGroup(StudNo: Code[20]; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudGroup: Record "Student Group";
        StudentGroup2: Record "Student Group";
        StudentMasterRec1: Record "Student Master-CS";
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        StudentTimelineREc: Record "Student Time Line";
        LastNo: Integer;
    begin
        StudentMasterRec1.Get(StudNo);

        StudGroup.Reset();
        StudGroup.SetRange("Groups Code", GroupCode);
        IF StudGroup.FindFirst() then;

        StudentGroup2.Reset();
        StudentGroup2.SetRange("Student No.", StudNo);
        StudentGroup2.SetRange("Groups Code", GroupCode);
        if not StudentGroup2.findfirst() then begin
            StudentGroup.Init();
            StudentGroup."Academic Year" := StudentMasterRec1."Academic Year";
            StudentGroup.Validate("Student No.", StudNo);
            StudentGroup.Semester := StudentMasterRec1.Semester;
            StudentGroup.Term := StudentMasterRec1.Term;
            StudentGroup."Enrollment No." := StudentMasterRec1."Enrollment No.";
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
            StudentGroup."Group Type" := StudGroup."Group Type";
            StudentGroup.Validate("Groups Code", GroupCode);
            StudentGroup."Modified By" := UserId();
            StudentGroup."Modified On" := Today();
            StudentGroup.Insert();

            StudentGroupLedger.Reset();
            if StudentGroupLedger.FINDLAST() then
                LastNo := StudentGroupLedger."Entry No." + 1
            else
                LastNo := 1;

            StudentGroupLedger1.Init();
            StudentGroupLedger1."Entry No." := LastNo;
            StudentGroupLedger1.Validate("Student No.", StudentGroup."Student No.");
            StudentGroupLedger1."Student Name" := StudentGroup."Student Name";
            StudentGroupLedger1."Academic Year" := StudentGroup."Academic Year";
            StudentGroupLedger1.Semester := StudentGroup.Semester;
            StudentGroupLedger1."Entry Date" := Today();
            StudentGroupLedger1."Entry Time" := Time();
            StudentGroupLedger1."Global Dimension 1 Code" := StudentGroup."Global Dimension 1 Code";
            StudentGroupLedger1."Global Dimension 2 Code" := StudentGroup."Global Dimension 2 Code";
            StudentGroupLedger1."User ID" := FORMAT(UserId());
            StudentGroupLedger1."Group Code" := GroupCode;
            StudentGroupLedger1."Group Type" := StudentGroup."Group Type";
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
            StudentGroupLedger1.Insert();

        end else begin
            StudentGroup2."Academic Year" := StudentMasterRec1."Academic Year";
            StudentGroup2.Semester := StudentMasterRec1.Semester;
            StudentGroup2.Term := StudentMasterRec1.Term;
            StudentGroup2."Enrollment No." := StudentMasterRec1."Enrollment No.";
            StudentGroup2."Created By" := FORMAT(UserId());
            StudentGroup2."Creation Date" := Today();
            StudentGroup2.Validate("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
            StudentGroup2."Group Type" := StudGroup."Group Type";
            StudentGroup2."Modified By" := UserId();
            StudentGroup2."Modified On" := Today();
            //StudentGroup2.Validate("Groups Code", GroupCode);
            StudentGroup2.Modify();

            StudentGroupLedger.Reset();
            if StudentGroupLedger.FINDLAST() then
                LastNo := StudentGroupLedger."Entry No." + 1
            else
                LastNo := 1;

            StudentGroupLedger1.Init();
            StudentGroupLedger1."Entry No." := LastNo;
            StudentGroupLedger1.Validate("Student No.", StudentGroup2."Student No.");
            StudentGroupLedger1."Student Name" := StudentGroup2."Student Name";
            StudentGroupLedger1."Academic Year" := StudentGroup2."Academic Year";
            StudentGroupLedger1.Semester := StudentGroup2.Semester;
            StudentGroupLedger1."Entry Date" := Today();
            StudentGroupLedger1."Entry Time" := Time();
            StudentGroupLedger1."Global Dimension 1 Code" := StudentGroup2."Global Dimension 1 Code";
            StudentGroupLedger1."Global Dimension 2 Code" := StudentGroup2."Global Dimension 2 Code";
            StudentGroupLedger1."User ID" := FORMAT(UserId());
            StudentGroupLedger1."Group Code" := GroupCode;
            StudentGroupLedger1."Group Type" := StudentGroup2."Group Type";
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
            StudentGroupLedger1.Insert();
        end;

        //TimeLine Insert Added ==== 01-09-2021
        StudentTimelineREc.InsertRecordFun(StudentMasterRec1."No.", StudentMasterRec1."Student Name", StudGroup.Description + ' has been Enabled', UserId(), Today());
        //TimeLine Insert Added ==== 01-09-2021
    End;

    procedure UnassignStudentBulkGroup(StudNo: Code[20]; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentTimeLineRec: Record "Student Time Line";
    begin
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudNo);
        StudentGroup.SetRange(StudentGroup."Groups Code", GroupCode);
        if StudentGroup.findfirst() then begin
            StudentTimeLineRec.InsertRecordFun(StudentGroup."Student No.", StudentGroup."Student Name", StudentGroup.Description + ' has been disabled.', userID(), Today());
            StudentGroup.Delete(true);
        end;

    end;

    procedure AssignStudentWiseBulkHold(StudNo: Code[20]; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentRec.Get(StudNo);

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.Setrange("Student No.", StudNo);
            StudentWiseHoldRec.SetRange("Group Code", GroupCode);
            If not StudentWiseHoldRec.FindFirst() then begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", StudentRec."No.");
                StudentWiseHoldRec."Student Name" := StudentRec."Student Name";
                StudentWiseHoldRec."Academic Year" := StudentRec."Academic Year";
                StudentWiseHoldRec."Admitted Year" := StudentRec."Admitted Year";
                StudentWiseHoldRec.Semester := StudentRec.Semester;
                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Group Code" := GroupCode;
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                StudentWiseHoldRec.Insert();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger.Validate("Student No.", StudentRec."No.");
                RecHoldStatusLedger."Student Name" := StudentRec."Student Name";
                RecHoldStatusLedger."Academic Year" := StudentRec."Academic Year";
                RecHoldStatusLedger."Admitted Year" := StudentRec."Admitted Year";
                RecHoldStatusLedger."Group Code" := GroupCode;
                RecHoldStatusLedger.Semester := StudentRec.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Enable;
                RecHoldStatusLedger.Insert();
            end else begin
                StudentWiseHoldRec."Student Name" := StudentRec."Student Name";
                StudentWiseHoldRec."Academic Year" := StudentRec."Academic Year";
                StudentWiseHoldRec."Admitted Year" := StudentRec."Admitted Year";
                StudentWiseHoldRec.Semester := StudentRec.Semester;
                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                StudentWiseHoldRec."Group Code" := GroupCode;
                StudentWiseHoldRec.Modify();

                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger.Validate("Student No.", StudentRec."No.");
                RecHoldStatusLedger."Student Name" := StudentRec."Student Name";
                RecHoldStatusLedger."Academic Year" := StudentRec."Academic Year";
                RecHoldStatusLedger."Admitted Year" := StudentRec."Admitted Year";
                RecHoldStatusLedger.Semester := StudentRec.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Group Code" := StudentHoldRec."Group Code";
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Enable;
                RecHoldStatusLedger.Insert();

            end;
        end;

    end;

    procedure UnassignStudentWiseBulkHold(StudNo: Code[20]; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentRec.Get(StudNo);

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", StudentRec."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
            if StudentWiseHoldRec.findfirst() then begin
                // StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
                // StudentWiseHoldRec.Modify();
                // Changed to Delete, code is in the last


                RecHoldStatusLedger.Reset();
                if RecHoldStatusLedger.FINDLAST() then
                    LastNo := RecHoldStatusLedger."Entry No." + 1
                else
                    LastNo := 1;

                RecHoldStatusLedger.Init();
                RecHoldStatusLedger."Entry No." := LastNo;
                RecHoldStatusLedger.Validate("Student No.", StudentRec."No.");
                RecHoldStatusLedger."Student Name" := StudentRec."Student Name";
                RecHoldStatusLedger."Academic Year" := StudentRec."Academic Year";
                RecHoldStatusLedger."Admitted Year" := StudentRec."Admitted Year";
                RecHoldStatusLedger.Semester := StudentRec.Semester;
                RecHoldStatusLedger."Entry Date" := Today();
                RecHoldStatusLedger."Entry Time" := Time();
                RecHoldStatusLedger."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
                RecHoldStatusLedger."Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
                RecHoldStatusLedger."User ID" := FORMAT(UserId());
                RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Disable;
                RecHoldStatusLedger.Insert();

                StudentWiseHoldRec.Delete();
            end;


        end;
    end;

    Procedure OnGroundCheckInStudentGroupEnable(StudentNo: Code[20])
    Var
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentMaster_lRec: Record "Student Master-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        LastNo_lInt: Integer;
    Begin
        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        StudentGroup_lRec.SetRange("Groups Code", 'ONGRDCI');
        IF Not StudentGroup_lRec.FindFirst() then begin
            StudentGroup_lRec.Init();
            StudentGroup_lRec.Validate("Student No.", StudentNo);
            StudentGroup_lRec.Validate("Groups Code", 'ONGRDCI');
            StudentGroup_lRec."Created By" := UserId();
            StudentGroup_lRec."Creation Date" := Today();
            StudentGroup_lRec."Modified By" := UserId();
            StudentGroup_lRec."Modified On" := Today();
            StudentGroup_lRec."Group Type" := StudentGroup_lRec."Group Type"::" ";
            EducationSetup_lRec.Reset();
            If EducationSetup_lRec.FindFirst() then begin
                StudentGroup_lRec."Academic Year" := EducationSetup_lRec."Academic Year";
                StudentGroup_lRec.Term := EducationSetup_lRec."Even/Odd Semester";
            end;

            StudentGroup_lRec.Insert();

            StudentGroupLedger_lRec.Reset();
            IF StudentGroupLedger_lRec.FindLast() then
                LastNo_lInt := StudentGroupLedger_lRec."Entry No." + 1
            Else
                LastNo_lInt := 1;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("No.", StudentNo);
            IF StudentMaster_lRec.FindFirst() then begin
                StudentGroupLedger_lRec.Init();
                StudentGroupLedger_lRec."Entry No." := LastNo_lInt;
                StudentGroupLedger_lRec."Entry Date" := Today();
                StudentGroupLedger_lRec."Entry Time" := Time();
                StudentGroupLedger_lRec."Student No." := StudentMaster_lRec."No.";
                StudentGroupLedger_lRec."Group Code" := 'ONGRDCI';
                StudentGroupLedger_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                StudentGroupLedger_lRec."Student Name" := StudentMaster_lRec."Student Name";
                StudentGroupLedger_lRec.Semester := StudentMaster_lRec.Semester;
                StudentGroupLedger_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                StudentGroupLedger_lRec."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                StudentGroupLedger_lRec."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                StudentGroupLedger_lRec."Group Type" := StudentGroupLedger_lRec."Group Type"::" ";
                StudentGroupLedger_lRec.Status := StudentGroupLedger_lRec.Status::Enable;
                StudentGroupLedger_lRec."Modified By" := UserId();
                StudentGroupLedger_lRec."Modified On" := Today();
                StudentGroupLedger_lRec."User ID" := UserId();
                StudentGroupLedger_lRec.Insert();
            end;
        end;
    End;

    Procedure OnGroundCheckInStudentGroupDisable(StudentNo: Code[20])
    Var
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo_lInt: Integer;
    Begin
        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        StudentGroup_lRec.SetRange("Groups Code", 'ONGRDCI');
        IF StudentGroup_lRec.FindFirst() then begin
            StudentGroup_lRec.Delete();

            StudentGroupLedger_lRec.Reset();
            IF StudentGroupLedger_lRec.FindLast() then
                LastNo_lInt := StudentGroupLedger_lRec."Entry No." + 1
            Else
                LastNo_lInt := 1;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("No.", StudentNo);
            IF StudentMaster_lRec.FindFirst() then begin
                StudentGroupLedger_lRec.Init();
                StudentGroupLedger_lRec."Entry No." := LastNo_lInt;
                StudentGroupLedger_lRec."Entry Date" := Today();
                StudentGroupLedger_lRec."Entry Time" := Time();
                StudentGroupLedger_lRec."Student No." := StudentMaster_lRec."No.";
                StudentGroupLedger_lRec."Group Code" := 'ONGRDCI';
                StudentGroupLedger_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                StudentGroupLedger_lRec."Student Name" := StudentMaster_lRec."Student Name";
                StudentGroupLedger_lRec.Semester := StudentMaster_lRec.Semester;
                StudentGroupLedger_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                StudentGroupLedger_lRec."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                StudentGroupLedger_lRec."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                StudentGroupLedger_lRec."Group Type" := StudentGroupLedger_lRec."Group Type"::" ";
                StudentGroupLedger_lRec.Status := StudentGroupLedger_lRec.Status::Disable;
                StudentGroupLedger_lRec."Modified By" := UserId();
                StudentGroupLedger_lRec."Modified On" := Today();
                StudentGroupLedger_lRec."User ID" := UserId();
                StudentGroupLedger_lRec.Insert();
            end;
        end;
    End;

    Procedure OnGroundCheckInCompletedGroupEnable(StudentNo: Code[20])
    Var
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentMaster_lRec: Record "Student Master-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        LastNo_lInt: Integer;
    Begin
        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        StudentGroup_lRec.SetRange("Groups Code", 'ONGRDCIC');
        IF Not StudentGroup_lRec.FindFirst() then begin
            StudentGroup_lRec.Init();
            StudentGroup_lRec.Validate("Student No.", StudentNo);
            StudentGroup_lRec.Validate("Groups Code", 'ONGRDCIC');
            StudentGroup_lRec."Created By" := UserId();
            StudentGroup_lRec."Creation Date" := Today();
            StudentGroup_lRec."Modified By" := UserId();
            StudentGroup_lRec."Modified On" := Today();
            StudentGroup_lRec."Group Type" := StudentGroup_lRec."Group Type"::" ";
            EducationSetup_lRec.Reset();
            If EducationSetup_lRec.FindFirst() then begin
                StudentGroup_lRec."Academic Year" := EducationSetup_lRec."Academic Year";
                StudentGroup_lRec.Term := EducationSetup_lRec."Even/Odd Semester";
            end;
            StudentGroup_lRec.Insert();

            StudentGroupLedger_lRec.Reset();
            IF StudentGroupLedger_lRec.FindLast() then
                LastNo_lInt := StudentGroupLedger_lRec."Entry No." + 1
            Else
                LastNo_lInt := 1;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("No.", StudentNo);
            IF StudentMaster_lRec.FindFirst() then begin
                StudentGroupLedger_lRec.Init();
                StudentGroupLedger_lRec."Entry No." := LastNo_lInt;
                StudentGroupLedger_lRec."Entry Date" := Today();
                StudentGroupLedger_lRec."Entry Time" := Time();
                StudentGroupLedger_lRec."Student No." := StudentMaster_lRec."No.";
                StudentGroupLedger_lRec."Group Code" := 'ONGRDCIC';
                StudentGroupLedger_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                StudentGroupLedger_lRec."Student Name" := StudentMaster_lRec."Student Name";
                StudentGroupLedger_lRec.Semester := StudentMaster_lRec.Semester;
                StudentGroupLedger_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                StudentGroupLedger_lRec."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                StudentGroupLedger_lRec."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                StudentGroupLedger_lRec."Group Type" := StudentGroupLedger_lRec."Group Type"::" ";
                StudentGroupLedger_lRec.Status := StudentGroupLedger_lRec.Status::Enable;
                StudentGroupLedger_lRec."Modified By" := UserId();
                StudentGroupLedger_lRec."Modified On" := Today();
                StudentGroupLedger_lRec."User ID" := UserId();
                StudentGroupLedger_lRec.Insert();
            end;
        end;
    End;

    PRocedure OnGroundCheckInCompletedGroupDisable(StudentNo: Code[20])
    Var
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo_lInt: Integer;
    Begin
        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        StudentGroup_lRec.SetRange("Groups Code", 'ONGRDCIC');
        IF StudentGroup_lRec.FindFirst() then begin
            StudentGroup_lRec.Delete();

            StudentGroupLedger_lRec.Reset();
            IF StudentGroupLedger_lRec.FindLast() then
                LastNo_lInt := StudentGroupLedger_lRec."Entry No." + 1
            Else
                LastNo_lInt := 1;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("No.", StudentNo);
            IF StudentMaster_lRec.FindFirst() then begin
                StudentGroupLedger_lRec.Init();
                StudentGroupLedger_lRec."Entry No." := LastNo_lInt;
                StudentGroupLedger_lRec."Entry Date" := Today();
                StudentGroupLedger_lRec."Entry Time" := Time();
                StudentGroupLedger_lRec."Student No." := StudentMaster_lRec."No.";
                StudentGroupLedger_lRec."Group Code" := 'ONGRDCIC';
                StudentGroupLedger_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                StudentGroupLedger_lRec."Student Name" := StudentMaster_lRec."Student Name";
                StudentGroupLedger_lRec.Semester := StudentMaster_lRec.Semester;
                StudentGroupLedger_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                StudentGroupLedger_lRec."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                StudentGroupLedger_lRec."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                StudentGroupLedger_lRec."Group Type" := StudentGroupLedger_lRec."Group Type"::" ";
                StudentGroupLedger_lRec.Status := StudentGroupLedger_lRec.Status::Disable;
                StudentGroupLedger_lRec."Modified By" := UserId();
                StudentGroupLedger_lRec."Modified On" := Today();
                StudentGroupLedger_lRec."User ID" := UserId();
                StudentGroupLedger_lRec.Insert();
            end;
        end;
    End;

    // New Student Course Change Process------Start-------22-07-2021-------
    procedure StudentCourseChange(StudentNo: Code[20]; NewCourseCode: Code[20]; Var StudentMaster_lRec: Record "Student Master-CS")
    Var
        StudentBuffer_lRec: Record "Student Buffer";
        HousingWaiver_lRec: Record "Opt Out";
        HousingApplication_lRec: Record "Housing Application";
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentWiseHold_lRec: Record "Student Wise Holds";
        StudentRegistration_lRec: Record "Student Registration-CS";
        CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DtldCustLedgerEntry_lRec: Record "Detailed Cust. Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        BankAccountLedgerEntry_lRec: Record "Bank Account Ledger Entry";
        StatusChangeLogEntry_lRec: Record "Status Change Log entry";
        FerpaDetails_lRec: Record "FERPA Details";
        FerpaInfoHdr_lRec: Record "FERPA Information Header";
        FerpaModuleAllowed_lRec: Record "FERPA Module Allowed";
        PortalUser_lRec: Record "Portal User Login-CS";
        QualDetailStud_lRec: Record "Qualifying Detail Stud-CS";
        EnrollmentHistory_lRec: Record "Enrollment History";
        TransactionSyncBuffer_lRec: Record "Transactions Sync Buffer";
        CourseMaster_lRec: Record "Course Master-CS";
        StudentTimeLine_lRec: Record "Student Time Line";
        OldCourseCode: Code[20];
    Begin

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetFilter("Global Dimension 1 Code", '<>%1', StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            Error('Selected course must be same Institute Code');

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', NewCourseCode);

        StudentBuffer_lRec.Reset();
        StudentBuffer_lRec.SetRange("Student No.", StudentNo);
        IF StudentBuffer_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := StudentBuffer_lRec."Course Code";
                StudentBuffer_lRec."Course Code" := NewCourseCode;
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Buffer Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                StudentBuffer_lRec.Modify();
            until StudentBuffer_lRec.Next() = 0;
        end;

        HousingWaiver_lRec.Reset();
        HousingWaiver_lRec.SetRange("Student No.", StudentNo);
        IF HousingWaiver_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := HousingWaiver_lRec."Course Code";
                HousingWaiver_lRec."Course Code" := NewCourseCode;
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                HousingWaiver_lRec.Modify();
            until HousingWaiver_lRec.Next() = 0;
        end;

        HousingApplication_lRec.Reset();
        HousingApplication_lRec.SetRange("Student No.", StudentNo);
        // HousingApplication_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
        // HousingApplication_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
        IF HousingApplication_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := HousingApplication_lRec."Course Code";
                HousingApplication_lRec."Course Code" := NewCourseCode;
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                HousingApplication_lRec.Modify();
            until HousingApplication_lRec.Next() = 0;
        end;

        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        IF StudentGroup_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := StudentGroup_lRec."Course Code";
                StudentGroup_lRec.Validate("Course Code", NewCourseCode);
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Group Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                StudentGroup_lRec.Modify();
            until StudentGroup_lRec.Next() = 0;
        end;

        StudentRegistration_lRec.Reset();
        StudentRegistration_lRec.SetRange("Student No", StudentNo);
        IF StudentRegistration_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := StudentRegistration_lRec."Course Code";
                StudentRegistration_lRec.Rename(StudentNo, NewCourseCode, StudentRegistration_lRec."Academic Year", StudentRegistration_lRec.Semester, StudentRegistration_lRec.Term);
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Registration Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
            until StudentRegistration_lRec.Next() = 0;
        end;

        CustomerLedgerEntry_lRec.Reset();
        CustomerLedgerEntry_lRec.Setrange("Enrollment No.", StudentMaster_lRec."Enrollment No.");
        IF CustomerLedgerEntry_lRec.FindSet() then begin
            repeat
                OldCourseCode := '';
                OldCourseCode := CustomerLedgerEntry_lRec."Course Code";
                CustomerLedgerEntry_lRec."Course Code" := NewCourseCode;
                StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Customer Ledger Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                CustomerLedgerEntry_lRec.Modify();

                GLEntry_lRec.Reset();
                GLEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                GLEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                IF GLEntry_lRec.FindSet() then begin
                    repeat
                        OldCourseCode := '';
                        OldCourseCode := GLEntry_lRec."Course Code";
                        GLEntry_lRec."Course Code" := NewCourseCode;
                        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'GL Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                        GLEntry_lRec.Modify();
                    until GLEntry_lRec.Next() = 0;
                end;

                DtldCustLedgerEntry_lRec.Reset();
                DtldCustLedgerEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                DtldCustLedgerEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                IF DtldCustLedgerEntry_lRec.FindSet() then begin
                    repeat
                        OldCourseCode := '';
                        OldCourseCode := DtldCustLedgerEntry_lRec."Course Code";
                        DtldCustLedgerEntry_lRec."Course Code" := NewCourseCode;
                        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Dtld Customer Ledger Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                        DtldCustLedgerEntry_lRec.Modify();
                    until DtldCustLedgerEntry_lRec.Next() = 0;
                end;

            until CustomerLedgerEntry_lRec.Next() = 0;
        end;

        OldCourseCode := '';
        OldCourseCode := StudentMaster_lRec."Course Code";

        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Master Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        CourseMaster_lRec.SetRange("Course Change Allowed", true);
        IF CourseMaster_lRec.FindFirst() then begin
            StudentMaster_lRec."Course Code" := NewCourseCode;
            StudentMaster_lRec."Course Name" := CourseMaster_lRec.Description;
        end;
        StudentMaster_lRec.Modify();
    End;

    // New Student Course Change Process------End-------22-07-2021-------


    // Student Data Update (Readmit) -------Start------22-07-2021

    procedure StudentReadmitProcess(StudentNo: Code[20]; EnrollmentNo: Code[20]; StatusCode: Option; DigitID: Text[18]; NewCourseCode: Code[20]; Sem: Code[20]; AcademicYear: Code[20]; Term: Option; StudentMaster_lRec: Record "Student Master-CS")
    Var
        StudentBuffer_lRec: Record "Student Buffer";
        HousingWaiver_lRec: Record "Opt Out";
        HousingApplication_lRec: Record "Housing Application";
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentWiseHold_lRec: Record "Student Wise Holds";
        StudentRegistration_lRec: Record "Student Registration-CS";
        CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DtldCustLedgerEntry_lRec: Record "Detailed Cust. Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        BankAccountLedgerEntry_lRec: Record "Bank Account Ledger Entry";
        StatusChangeLogEntry_lRec: Record "Status Change Log entry";
        FerpaDetails_lRec: Record "FERPA Details";
        FerpaInfoHdr_lRec: Record "FERPA Information Header";
        FerpaModuleAllowed_lRec: Record "FERPA Module Allowed";
        PortalUser_lRec: Record "Portal User Login-CS";
        QualDetailStud_lRec: Record "Qualifying Detail Stud-CS";
        EnrollmentHistory_lRec: Record "Enrollment History";
        TransactionSyncBuffer_lRec: Record "Transactions Sync Buffer";
        StudentStatus_lRec: Record "Student Status";
        CourseMaster_lRec: Record "Course Master-CS";
    Begin
        StudentStatus_lRec.Reset();
        StudentStatus_lRec.SetRange(Status, StatusCode);
        IF StudentStatus_lRec.FindFirst() then;

        IF NewCourseCode <> '' then
            ReadmitStudentCourseChange(StudentNo, NewCourseCode, StudentMaster_lRec);
        StudentMaster_lRec.Modify();

        //StudentMaster_lRec."Enrollment No." := EnrollmentNo;
        StudentMaster_lRec."18 Digit ID" := DigitID;
        StudentMaster_lRec.Semester := Sem;
        StudentMaster_lRec."Academic Year" := AcademicYear;
        StudentMaster_lRec.Term := Term;
        StudentMaster_lRec.Validate(Status, StudentStatus_lRec.Code);

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        IF CourseMaster_lRec.FindFirst() then
            StudentMaster_lRec."Course Name" := CourseMaster_lRec.Description;
        StudentMaster_lRec.Modify(true);

    End;

    // Student Data Update (Readmit) -------End------22-07-2021

    procedure ReadmitStudentCourseChange(StudentNo: Code[20]; NewCourseCode: Code[20]; Var StudentMaster_lRec: Record "Student Master-CS")
    Var
        StudentBuffer_lRec: Record "Student Buffer";
        HousingWaiver_lRec: Record "Opt Out";
        HousingApplication_lRec: Record "Housing Application";
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentWiseHold_lRec: Record "Student Wise Holds";
        StudentRegistration_lRec: Record "Student Registration-CS";
        CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DtldCustLedgerEntry_lRec: Record "Detailed Cust. Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        BankAccountLedgerEntry_lRec: Record "Bank Account Ledger Entry";
        StatusChangeLogEntry_lRec: Record "Status Change Log entry";
        FerpaDetails_lRec: Record "FERPA Details";
        FerpaInfoHdr_lRec: Record "FERPA Information Header";
        FerpaModuleAllowed_lRec: Record "FERPA Module Allowed";
        PortalUser_lRec: Record "Portal User Login-CS";
        QualDetailStud_lRec: Record "Qualifying Detail Stud-CS";
        EnrollmentHistory_lRec: Record "Enrollment History";
        TransactionSyncBuffer_lRec: Record "Transactions Sync Buffer";
        CourseMaster_lRec: Record "Course Master-CS";
        StudentTimeLine_lRec: Record "Student Time Line";
        EducationSetup_lRec: Record "Education Setup-CS";
        OldCourseCode: Code[20];
    Begin

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetFilter("Global Dimension 1 Code", '<>%1', StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            Error('Selected course must be same Institute Code');

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, StudentMaster_lRec."Course Code");
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', StudentMaster_lRec."Course Code");

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', NewCourseCode);

        EducationSetup_lRec.Reset();
        EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        If EducationSetup_lRec.FindFirst() then begin

            HousingWaiver_lRec.Reset();
            HousingWaiver_lRec.SetRange("Student No.", StudentNo);
            HousingWaiver_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            HousingWaiver_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF HousingWaiver_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := HousingWaiver_lRec."Course Code";
                    HousingWaiver_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    HousingWaiver_lRec.Modify();
                until HousingWaiver_lRec.Next() = 0;
            end;

            HousingApplication_lRec.Reset();
            HousingApplication_lRec.SetRange("Student No.", StudentNo);
            HousingApplication_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            HousingApplication_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF HousingApplication_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := HousingApplication_lRec."Course Code";
                    HousingApplication_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    HousingApplication_lRec.Modify();
                until HousingApplication_lRec.Next() = 0;
            end;

            StudentGroup_lRec.Reset();
            StudentGroup_lRec.SetRange("Student No.", StudentNo);
            StudentGroup_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            StudentGroup_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF StudentGroup_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := StudentGroup_lRec."Course Code";
                    StudentGroup_lRec.Validate("Course Code", NewCourseCode);
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Group Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    StudentGroup_lRec.Modify();
                until StudentGroup_lRec.Next() = 0;
            end;

            StudentRegistration_lRec.Reset();
            StudentRegistration_lRec.SetRange("Student No", StudentNo);
            StudentRegistration_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            StudentRegistration_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF StudentRegistration_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := StudentRegistration_lRec."Course Code";
                    StudentRegistration_lRec.Rename(StudentNo, NewCourseCode, StudentRegistration_lRec."Academic Year", StudentRegistration_lRec.Semester, StudentRegistration_lRec.Term);
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Registration Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                until StudentRegistration_lRec.Next() = 0;
            end;

            CustomerLedgerEntry_lRec.Reset();
            CustomerLedgerEntry_lRec.Setrange("Enrollment No.", StudentMaster_lRec."Enrollment No.");
            CustomerLedgerEntry_lRec.Setrange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            CustomerLedgerEntry_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF CustomerLedgerEntry_lRec.FindSet() then begin
                //Message('Entry(s) Found in Customer Ledger Entry, please contact Bursar Department.');
                repeat
                    OldCourseCode := '';
                    OldCourseCode := CustomerLedgerEntry_lRec."Course Code";
                    CustomerLedgerEntry_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Customer Ledger Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    CustomerLedgerEntry_lRec.Modify();

                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                    GLEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                    IF GLEntry_lRec.FindSet() then begin
                        repeat
                            OldCourseCode := '';
                            OldCourseCode := GLEntry_lRec."Course Code";
                            GLEntry_lRec."Course Code" := NewCourseCode;
                            StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'GL Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                            GLEntry_lRec.Modify();
                        until GLEntry_lRec.Next() = 0;
                    end;

                    DtldCustLedgerEntry_lRec.Reset();
                    DtldCustLedgerEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                    DtldCustLedgerEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                    IF DtldCustLedgerEntry_lRec.FindSet() then begin
                        repeat
                            OldCourseCode := '';
                            OldCourseCode := DtldCustLedgerEntry_lRec."Course Code";
                            DtldCustLedgerEntry_lRec."Course Code" := NewCourseCode;
                            StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Dtld Customer Ledger Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                            DtldCustLedgerEntry_lRec.Modify();
                        until DtldCustLedgerEntry_lRec.Next() = 0;
                    end;

                until CustomerLedgerEntry_lRec.Next() = 0;
            end;
        end;

        OldCourseCode := '';
        OldCourseCode := StudentMaster_lRec."Course Code";

        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Master Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        CourseMaster_lRec.SetRange("Course Change Allowed", true);
        IF CourseMaster_lRec.FindFirst() then begin
            StudentMaster_lRec."Course Code" := NewCourseCode;
            StudentMaster_lRec."Course Name" := CourseMaster_lRec.Description;
        end;
        StudentMaster_lRec.Modify();
    End;

    procedure CourseChangeManually(StudentNo: Code[20]; NewCourseCode: Code[20]; Var StudentMaster_lRec: Record "Student Master-CS")
    Var
        StudentBuffer_lRec: Record "Student Buffer";
        HousingWaiver_lRec: Record "Opt Out";
        HousingApplication_lRec: Record "Housing Application";
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentWiseHold_lRec: Record "Student Wise Holds";
        StudentRegistration_lRec: Record "Student Registration-CS";
        CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DtldCustLedgerEntry_lRec: Record "Detailed Cust. Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        BankAccountLedgerEntry_lRec: Record "Bank Account Ledger Entry";
        StatusChangeLogEntry_lRec: Record "Status Change Log entry";
        FerpaDetails_lRec: Record "FERPA Details";
        FerpaInfoHdr_lRec: Record "FERPA Information Header";
        FerpaModuleAllowed_lRec: Record "FERPA Module Allowed";
        PortalUser_lRec: Record "Portal User Login-CS";
        QualDetailStud_lRec: Record "Qualifying Detail Stud-CS";
        EnrollmentHistory_lRec: Record "Enrollment History";
        TransactionSyncBuffer_lRec: Record "Transactions Sync Buffer";
        CourseMaster_lRec: Record "Course Master-CS";
        StudentTimeLine_lRec: Record "Student Time Line";
        EducationSetup_lRec: Record "Education Setup-CS";
        OldCourseCode: Code[20];
    Begin

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetFilter("Global Dimension 1 Code", '<>%1', StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            Error('Selected course must be same Institute Code');

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, StudentMaster_lRec."Course Code");
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', StudentMaster_lRec."Course Code");

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', NewCourseCode);

        EducationSetup_lRec.Reset();
        EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        If EducationSetup_lRec.FindFirst() then begin

            HousingWaiver_lRec.Reset();
            HousingWaiver_lRec.SetRange("Student No.", StudentNo);
            HousingWaiver_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            HousingWaiver_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF HousingWaiver_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := HousingWaiver_lRec."Course Code";
                    HousingWaiver_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    HousingWaiver_lRec.Modify();
                until HousingWaiver_lRec.Next() = 0;
            end;

            HousingApplication_lRec.Reset();
            HousingApplication_lRec.SetRange("Student No.", StudentNo);
            HousingApplication_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            HousingApplication_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF HousingApplication_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := HousingApplication_lRec."Course Code";
                    HousingApplication_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Housing Waiver Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    HousingApplication_lRec.Modify();
                until HousingApplication_lRec.Next() = 0;
            end;

            StudentGroup_lRec.Reset();
            StudentGroup_lRec.SetRange("Student No.", StudentNo);
            StudentGroup_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            StudentGroup_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF StudentGroup_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := StudentGroup_lRec."Course Code";
                    StudentGroup_lRec.Validate("Course Code", NewCourseCode);
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Group Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    StudentGroup_lRec.Modify();
                until StudentGroup_lRec.Next() = 0;
            end;

            StudentRegistration_lRec.Reset();
            StudentRegistration_lRec.SetRange("Student No", StudentNo);
            StudentRegistration_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            StudentRegistration_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF StudentRegistration_lRec.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := StudentRegistration_lRec."Course Code";
                    StudentRegistration_lRec.Rename(StudentNo, NewCourseCode, StudentRegistration_lRec."Academic Year", StudentRegistration_lRec.Semester, StudentRegistration_lRec.Term);
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Registration Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                until StudentRegistration_lRec.Next() = 0;
            end;

            CustomerLedgerEntry_lRec.Reset();
            CustomerLedgerEntry_lRec.Setrange("Enrollment No.", StudentMaster_lRec."Enrollment No.");
            CustomerLedgerEntry_lRec.Setrange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            CustomerLedgerEntry_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
            IF CustomerLedgerEntry_lRec.FindSet() then begin
                Message('Entry(s) Found in Customer Ledger Entry, please contact Bursar Department.');
                repeat
                    OldCourseCode := '';
                    OldCourseCode := CustomerLedgerEntry_lRec."Course Code";
                    CustomerLedgerEntry_lRec."Course Code" := NewCourseCode;
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Customer Ledger Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    CustomerLedgerEntry_lRec.Modify();

                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                    GLEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                    IF GLEntry_lRec.FindSet() then begin
                        repeat
                            OldCourseCode := '';
                            OldCourseCode := GLEntry_lRec."Course Code";
                            GLEntry_lRec."Course Code" := NewCourseCode;
                            StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'GL Entry Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                            GLEntry_lRec.Modify();
                        until GLEntry_lRec.Next() = 0;
                    end;

                    DtldCustLedgerEntry_lRec.Reset();
                    DtldCustLedgerEntry_lRec.SetRange("Enrollment No.", CustomerLedgerEntry_lRec."Enrollment No.");
                    DtldCustLedgerEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                    IF DtldCustLedgerEntry_lRec.FindSet() then begin
                        repeat
                            OldCourseCode := '';
                            OldCourseCode := DtldCustLedgerEntry_lRec."Course Code";
                            DtldCustLedgerEntry_lRec."Course Code" := NewCourseCode;
                            StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Dtld Customer Ledger Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                            DtldCustLedgerEntry_lRec.Modify();
                        until DtldCustLedgerEntry_lRec.Next() = 0;
                    end;

                until CustomerLedgerEntry_lRec.Next() = 0;
            end;
        end;

        OldCourseCode := '';
        OldCourseCode := StudentMaster_lRec."Course Code";

        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Student Master Course has been changed ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        CourseMaster_lRec.SetRange("Course Change Allowed", true);
        IF CourseMaster_lRec.FindFirst() then begin
            StudentMaster_lRec."Course Code" := NewCourseCode;
            StudentMaster_lRec."Course Name" := CourseMaster_lRec.Description;
        end;
        StudentMaster_lRec.Modify();
    End;

    procedure ResetStudentforOLR(CourseCode: Code[20]; StudentType: Option " ",New,Returning)
    var
        StudentMaster_lRec: Record "Student Master-CS";
        HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        TotalCount: Integer;
        Counter: Integer;
    Begin
        WindowDialog.Open('Reset OLR Information...\' + Text001Lbl);
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Course Code", CourseCode);
        IF StudentType = StudentType::New then
            StudentMaster_lRec.SetRange("Returning Student", False);
        If StudentType = StudentType::Returning then begin
            StudentMaster_lRec.SetRange("Returning Student", true);
            //StudentMaster_lRec.SetRange("OLR Completed", true);
        end;
        TotalCount := StudentMaster_lRec.Count();
        If StudentMaster_lRec.FindSet() then begin
            repeat
                Counter += 1;
                WindowDialog.Update(1, StudentMaster_lRec."Student Name" + ' ' + StudentMaster_lRec."Original Student No." + ' ' + format(Counter) + ' of ' + Format(TotalCount));
                StudentMaster_lRec."Registrar Signoff" := false;
                StudentMaster_lRec."OLR Completed" := false;
                StudentMaster_lRec."OLR Completed Date" := 0D;
                IF StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In" then
                    HoldBulkUpload_lCU.OnGroundCheckInStudentGroupDisable(StudentMaster_lRec."No.");
                IF StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In Completed" then
                    HoldBulkUpload_lCU.OnGroundCheckInCompletedGroupDisable(StudentMaster_lRec."No.");
                StudentMaster_lRec."Student Group" := StudentMaster_lRec."Student Group"::" ";
                StudentMaster_lRec."On Ground Check-In By" := '';
                StudentMaster_lRec."On Ground Check-In On" := 0D;
                StudentMaster_lRec."On Ground Check-In Complete By" := '';
                StudentMaster_lRec."On Ground Check-In Complete On" := 0D;
                StudentMaster_lRec."OLR Email Sent" := false;
                StudentMaster_lRec."OLR Email Sent Date" := 0D;
                StudentMaster_lRec."Promotion Suggested" := false;
                StudentMaster_lRec."FERPA Release" := StudentMaster_lRec."FERPA Release"::" ";
                StudentMaster_lRec."Ferpa Release Date" := 0D;
                StudentMaster_lRec."Semester Decision" := StudentMaster_lRec."Semester Decision"::" ";
                StudentMaster_lRec."Clear OLR Data" := false;
                StudentMaster_lRec.Modify();
                CondRegistrationGroupDisable(StudentMaster_lRec."No.");
            until StudentMaster_lRec.Next() = 0;
        end;
        WindowDialog.Close();
    End;

    Procedure CondRegistrationGroupDisable(StudentNo: Code[20])
    Var
        StudentGroup_lRec: Record "Student Group";
        StudentGroupLedger_lRec: Record "Student Group Ledger";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo_lInt: Integer;
    Begin
        StudentGroup_lRec.Reset();
        StudentGroup_lRec.SetRange("Student No.", StudentNo);
        StudentGroup_lRec.SetRange("Groups Code", 'CONDREG');
        IF StudentGroup_lRec.FindSet() then begin
            StudentGroup_lRec.DeleteAll();

            StudentGroupLedger_lRec.Reset();
            IF StudentGroupLedger_lRec.FindLast() then
                LastNo_lInt := StudentGroupLedger_lRec."Entry No." + 1
            Else
                LastNo_lInt := 1;

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("No.", StudentNo);
            IF StudentMaster_lRec.FindFirst() then begin
                StudentGroupLedger_lRec.Init();
                StudentGroupLedger_lRec."Entry No." := LastNo_lInt;
                StudentGroupLedger_lRec."Entry Date" := Today();
                StudentGroupLedger_lRec."Entry Time" := Time();
                StudentGroupLedger_lRec."Student No." := StudentMaster_lRec."No.";
                StudentGroupLedger_lRec."Group Code" := 'CONDREG';
                StudentGroupLedger_lRec."Academic Year" := StudentMaster_lRec."Academic Year";
                StudentGroupLedger_lRec."Student Name" := StudentMaster_lRec."Student Name";
                StudentGroupLedger_lRec.Semester := StudentMaster_lRec.Semester;
                StudentGroupLedger_lRec."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                StudentGroupLedger_lRec."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                StudentGroupLedger_lRec."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                StudentGroupLedger_lRec."Group Type" := StudentGroupLedger_lRec."Group Type"::" ";
                StudentGroupLedger_lRec.Status := StudentGroupLedger_lRec.Status::Disable;
                StudentGroupLedger_lRec."Modified By" := UserId();
                StudentGroupLedger_lRec."Modified On" := Today();
                StudentGroupLedger_lRec."User ID" := UserId();
                StudentGroupLedger_lRec.Insert();
            end;
        end;
    End;

    ///////////////////////GAURAV//5.12.22////
    procedure CourseChangeClinicalManually(StudentNo: Code[20]; NewCourseCode: Code[20]; Var StudentMaster_lRec: Record "Student Master-CS")
    Var
        StatusChangeLogEntry_lRec: Record "Status Change Log entry";
        CourseMaster_lRec: Record "Course Master-CS";
        StudentTimeLine_lRec: Record "Student Time Line";
        EducationSetup_lRec: Record "Education Setup-CS";
        StudentSubjectExam: Record "Student Subject Exam";
        MainStudent: Record "Main Student Subject-CS";
        RosterLedger: Record "Roster Ledger Entry";
        StudentMasterCS: Record "Student Master-CS";
        countValue: Integer;
        TotalCount: Integer;
        OldCourseCode: Code[20];
    begin


        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetFilter("Global Dimension 1 Code", '<>%1', StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            Error('Selected course must be same Institute Code');

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, StudentMaster_lRec."Course Code");
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', StudentMaster_lRec."Course Code");

        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        IF CourseMaster_lRec.FindFirst() then
            IF not CourseMaster_lRec."Course Change Allowed" then
                Error('Course Changes process is not applicable for the Course : %1', NewCourseCode);

        EducationSetup_lRec.Reset();
        EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        If EducationSetup_lRec.FindFirst() then begin

            TotalCount := 0;
            MainStudent.Reset();
            MainStudent.SetRange("Student No.", StudentNo);
            MainStudent.SetFilter("Start Date", '>=%1', Today());
            TotalCount := MainStudent.Count();

            For countValue := 1 to TotalCount do begin
                MainStudent.Reset();
                MainStudent.SetRange("Student No.", StudentNo);
                MainStudent.SetFilter("Start Date", '>=%1', Today());
                IF MainStudent.FindSet() then begin
                    repeat
                        OldCourseCode := '';
                        OldCourseCode := MainStudent.Course;
                        MainStudent.Rename(MainStudent."Student No.", NewCourseCode, MainStudent.Semester, MainStudent."Academic Year", MainStudent."Subject Code", MainStudent.Section, MainStudent."Start Date");
                        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Course (Main Student Subject) has been changed from' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                    until MainStudent.Next() = 0;
                end;
            end;

            StudentSubjectExam.Reset();
            StudentSubjectExam.SetRange("Student No.", StudentNo);
            StudentSubjectExam.SetFilter("Start Date", '>=%1', Today());
            IF StudentSubjectExam.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := StudentSubjectExam.Course;
                    StudentSubjectExam.Rename(StudentSubjectExam."Student No.", NewCourseCode, StudentSubjectExam.Semester, StudentSubjectExam."Academic Year", StudentSubjectExam."Subject Code", StudentSubjectExam.Section, StudentSubjectExam."Line No.");
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Course (Student Subject Exam) has been changed from ' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
                until StudentSubjectExam.Next() = 0;
            end;



            RosterLedger.Reset();
            RosterLedger.SetRange("Student ID", StudentNo);
            RosterLedger.setfilter("Start Date", '>=%1', Today());
            IF RosterLedger.FindSet() then begin
                repeat
                    OldCourseCode := '';
                    OldCourseCode := RosterLedger."Student Course Code";
                    RosterLedger.Validate("Student Course Code", NewCourseCode);
                    RosterLedger.Modify();
                    StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Course (Roster Ledger Entry) has been changed from' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());

                until RosterLedger.Next() = 0;
            end;

            // end;
        end;

        OldCourseCode := '';
        OldCourseCode := StudentMaster_lRec."Course Code";


        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, NewCourseCode);
        CourseMaster_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
        CourseMaster_lRec.SetRange("Course Change Allowed", true);
        IF CourseMaster_lRec.FindFirst() then begin
            StudentMaster_lRec."Course Code" := NewCourseCode;
            StudentMaster_lRec."Course Name" := CourseMaster_lRec.Description;
        end;
        StudentMaster_lRec.Modify();
        StudentTimeLine_lRec.InsertRecordFun(StudentNo, StudentMaster_lRec."Student Name", 'Course (Student Master ) has been changed from' + OldCourseCode + ' to ' + NewCourseCode, UserId(), Today());
    End;////GAURAV END//5.12.22//
}