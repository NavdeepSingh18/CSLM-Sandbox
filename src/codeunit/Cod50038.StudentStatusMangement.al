codeunit 50038 "Student Status Mangement"
{
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

        if ((StatusType = StatusType::Deposited) Or (StatusType = StatusType::Deferred) OR (StatusType = StatusType::Enrolled) or (StatusType = StatusType::TWD)) then begin

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

            // if (StatusType = StatusType::ROL) AND (SemesterSequence <> 5) then begin
            //if (StatusType = StatusType::ROL) then begin          CS:Navdeep-05-08-2021
            //IF (StatusType In [StatusType::ROL, StatusType::ELOA, StatusType::"Re-Entry", StatusType::TWD, StatusType::Probation]) then begin
            IF StatusType IN [StatusType::ROL, StatusType::Deposited, StatusType::"Re-Admitted"] then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;

            IF (StatusType In [StatusType::ELOA, StatusType::"Re-Entry", StatusType::Probation, StatusType::TWD]) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusType);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;


            // if (StatusType = StatusType::Enrolled) AND (SemesterSequence = 5) then begin
            //     StatusRec1.Reset();
            //     StatusRec1.SetRange("Global Dimension 1 Code", GD1);
            //     StatusRec1.SetRange(Status, StatusRec1.Status::Active);
            //     StatusRec1.findfirst();
            //     NewStatus := StatusRec1.Code;
            // end;
        end;

        if GD1 = '9100' then begin
            StatusRec.Reset();
            StatusRec.SetRange(code, OldStatus);
            StatusRec.SetRange("Global Dimension 1 Code", GD1);
            StatusRec.findfirst();
            StatusType := StatusRec.status;

            //if (StatusType = StatusType::ROL) then begin          CS:Navdeep-05-08-2021
            //IF (StatusType In [StatusType::ROL, StatusType::ELOA, StatusType::"Re-Entry", StatusType::TWD, StatusType::Probation]) then begin
            IF StatusType IN [StatusType::ROL, StatusType::Deposited] then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusRec1.Status::Active);
                StatusRec1.findfirst();
                NewStatus := StatusRec1.Code;
            end;

            IF (StatusType In [StatusType::ELOA, StatusType::"Re-Entry", StatusType::Probation, StatusType::TWD]) then begin
                StatusRec1.Reset();
                StatusRec1.SetRange("Global Dimension 1 Code", GD1);
                StatusRec1.SetRange(Status, StatusType);
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

        // StudentWiseHoldRec.Reset();
        // StudentWiseHoldRec.SetRange("Student No.", Stud."No.");
        // StudentWiseHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        // If StudentWiseHoldRec.FindSet() then
        //     StudentWiseHoldRec.DeleteAll();

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetFilter(StudentHoldRec."Hold Type", '<>%1&<>%2&<>%3&<>%4&<>%5',
        StudentHoldRec."Hold Type"::Registrar, StudentHoldRec."Hold Type"::"Registrar Sign-off",
        StudentHoldRec."Hold Type"::Immigration, StudentHoldRec."Hold Type"::" ", StudentHoldRec."Hold Type"::Bursar);
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
            Until StudentHoldRec.NEXT() = 0;
    end;

    procedure EnableAllHold(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentMaster_lRec: Record "Student Master-CS";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", Stud."Original Student No.");
        If StudentMaster_lRec.FindSet() then begin
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.Setrange("Student No.", StudentMaster_lRec."No.");
                    // StudentWiseHoldRec.Setrange("Academic Year", Stud."Academic Year");
                    // StudentWiseHoldRec.Setrange(Semester, Stud.Semester);
                    StudentWiseHoldRec.SetRange("Hold Type", HoldType);
                    if not StudentWiseHoldRec.FindFirst() then begin
                        StudentWiseHoldRec.Init();
                        StudentWiseHoldRec.Validate("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec."Student Name" := StudentMaster_lRec."Student Name";
                        StudentWiseHoldRec."Academic Year" := StudentMaster_lRec."Academic Year";
                        StudentWiseHoldRec."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        StudentWiseHoldRec.Semester := StudentMaster_lRec.Semester;

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
                        StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                        StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                        StudentWiseHoldRec.Insert();

                        RecHoldStatusLedger.Reset();
                        if RecHoldStatusLedger.FINDLAST() then
                            LastNo := RecHoldStatusLedger."Entry No." + 1
                        else
                            LastNo := 1;

                        RecHoldStatusLedger.Init();
                        RecHoldStatusLedger."Entry No." := LastNo;
                        RecHoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                        RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                        RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                        RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                        RecHoldStatusLedger."Entry Date" := Today();
                        RecHoldStatusLedger."Entry Time" := Time();
                        RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
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
                            RecHoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                            RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                            RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                            RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                            RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                            RecHoldStatusLedger."Entry Date" := Today();
                            RecHoldStatusLedger."Entry Time" := Time();
                            RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                            RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                            RecHoldStatusLedger."User ID" := FORMAT(UserId());
                            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                            RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                            RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                            RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                            RecHoldStatusLedger.Insert();

                        End;
                        // end else         //Commented 02-07-2021
                        //     Error('The %1 hold is already enabled.', StudentHoldRec."Hold Type");
                    end;
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
        // end else         //Commented 02-07-2021
        //     error('There is no data with in the filter.');
    end;

    procedure EnableRegistrarHold(Stud: Record "Student Master-CS");
    var
        StudentHoldRec: Record "Student Hold";
        StudentMaster_lRec: Record "Student Master-CS";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", Stud."Original Student No.");
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                StudentHoldRec.SetRange(StudentHoldRec."Hold Type", StudentHoldRec."Hold Type"::Registrar);
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Init();
                    StudentWiseHoldRec.Validate("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec."Student Name" := StudentMaster_lRec."Student Name";
                    StudentWiseHoldRec."Academic Year" := StudentMaster_lRec."Academic Year";
                    StudentWiseHoldRec."Admitted Year" := StudentMaster_lRec."Admitted Year";
                    StudentWiseHoldRec.Semester := StudentMaster_lRec.Semester;

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
                    StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                    StudentWiseHoldRec.Insert();

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                    RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                    RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                    RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status;
                    RecHoldStatusLedger.Insert();
                end else
                    error('There is no data with in the filter.');
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    procedure DisableRegistrarHold(Stud: Record "Student Master-CS");
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentMaster_lRec: Record "Student Master-CS";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
    begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", Stud."Original Student No.");
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                StudentWiseHoldRec.Reset();
                StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Registrar);
                If StudentWiseHoldRec.FindFirst() then begin

                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                    RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                    RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                    RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Registrar;
                    RecHoldStatusLedger."Group Code" := StudentWiseHoldRec."Group Code";
                    RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                    RecHoldStatusLedger.Insert();

                    StudentWiseHoldRec.DeleteAll(true);
                end;
            Until StudentMaster_lRec.Next() = 0;
        end;
        // end else
        //     Error('There is no data with in the filter');
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

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

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

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

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
    //     //SmtpMail.Send();

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

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

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

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

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
    //     //SmtpMail.Send();

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

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

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



    // procedure BroadcastEmailNotification(StudentNo: Code[20]; SubjectTxt: Text[250]; Body1: Text; Body2: Text[2048]; StudentEmailID: Boolean; AlternateEmailID: Boolean; EmailTempCode: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     RecBroadCastTemplate: Record "Intership-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCS";
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[250];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     IStream: InStream;
    //     Buffer: Text;
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     If StudentEmailID then begin
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //         Recipient := Studentmaster."E-Mail Address";
    //     end;
    //     If AlternateEmailID then begin
    //         Studentmaster.TestField(Studentmaster."Alternate Email Address");
    //         Recipient := Studentmaster."Alternate Email Address";
    //     end;
    //     RecBroadCastTemplate.reset;
    //     If RecBroadCastTemplate.Get(EmailTempCode) then begin
    //         RecBroadCastTemplate.CalcFields(TempBody);
    //         IF RecBroadCastTemplate.TempBody.HasValue then begin
    //             Clear(Body1);
    //             RecBroadCastTemplate.TempBody.CreateInStream(IStream);
    //             While not IStream.EOS do begin
    //                 IStream.ReadText(Buffer);
    //                 IF Not (buffer IN ['', ' ', '  ', '   ']) then
    //                     Body1 += Buffer
    //                 else
    //                     Body1 += '<br><br>';
    //             end;
    //         end;
    //     end;
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := SubjectTxt;

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     // SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ' ' + ',');//as per stuti including in template
    //     // SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(Body1);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody(Body2);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     // SmtpMail.AppendtoBody('Regards,');//as per stuti including in template
    //     // SmtpMail.AppendtoBody('<br><br>');//as per stuti including in template
    //     // SmtpMail.AppendtoBody(SenderName);//as per stuti including in template
    //     // SmtpMail.AppendtoBody('<br><br>');//as per stuti including in template
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     SMTPmail.send();
    //     WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('BroadcastEmail', 'MEA', SenderAddress, Studentmaster."Student Name"
    //     , StudentNo, SubjectTxt, Body1, 'Broadcast', '', '', format(Today(), 0, 9), Recipient, 1, Studentmaster."Mobile Number", '', 0);
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
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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
        StatusChangeLogEntryLog1: Record "Status Change Log Entry Log";
        NextLineNo: Integer;
    begin
        Clear(StatusChangeLogEntryLog);
        StatusChangeLogEntryLog.Reset();
        StatusChangeLogEntryLog.Init();
        StatusChangeLogEntryLog.TransferFields(StatusLog);
        StatusChangeLogEntryLog."Log Type" := LogType;
        StatusChangeLogEntryLog."Log Entry Created By" := UserId();
        StatusChangeLogEntryLog."Log Entry Created On" := today();

        StatusChangeLogEntryLog1.Reset();
        if StatusChangeLogEntryLog1.FindLast() then
            NextLineNo := StatusChangeLogEntryLog1."Log Entry No." + 1
        Else
            NextLineNo := 0;

        StatusChangeLogEntryLog."Log Entry No." := NextLineNo;
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
        StudentTimelineRec: Record "Student Time Line";
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
            end;

        end;
        //TimeLine Insert Added ===== 01-09-2021
        StudentTimelineRec.InsertRecordFun(Stud."No.", Stud."Student Name", Format(HoldType) + ' Hold has been enabled', userid(), Today());
        //TimeLine Insert Added ===== 01-09-2021
        //error('There is no data with in the filter.');
    end;

    procedure DisableAllHoldOLR(Stud: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentGroupRec: Record "Student Group";
        StudentTimelineRec: Record "Student Time Line";
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
            //TimeLine Insert Added ===== 01-09-2021
        StudentTimelineRec.InsertRecordFun(Stud."No.", Stud."Student Name", Format(HoldType) + ' Hold has been disabled', userid(), Today());
        //TimeLine Insert Added ===== 01-09-2021

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

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", StudentHoldRec."Hold Type"::Registrar);
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
        end;
    end;

    procedure UpdateGPA(StudentNo: Code[20]; Bypass: Boolean)
    var
        StudSub: Record "Main Student Subject-CS";
        CSemester: Record "Course Sem. Master-CS";
        // CSubject: Record "Course Wise Subject Line-CS";
        CourseMasterRec: Record "Course Master-CS";
        CourseMasterRec1: Record "Course Master-CS";
        Stud: Record "Student Master-CS";
        StudentMaster: Record "Student Master-CS";
        SemesterMaster: Record "Semester Master-CS";
        Grade: Record "Grade Master-CS";
        UserSetupRec: Record "User Setup";
        GradePointsArr: Array[50] of Decimal;
        CreditAttemptArr: array[50] of Decimal;
        GPA: array[50] of Decimal;
        Text001Lbl: Label 'Students No.     ############1################\';
        WindowDialog: Dialog;
        Ctr: Integer;
        CtrTot: Integer;
        SemesterTxt: Code[20];
        MultipleEnrollmentBool: Boolean;
        Int: Integer;
        TotQualityPoint: Decimal;
        TotCreditAttempt: Decimal;
        CourseFilter: Text;
    begin
        IF Bypass then
            WindowDialog.Open('Updating  GPA\' + Text001Lbl);
        Stud.Reset();
        Stud.SetRange("No.", StudentNo);
        CtrTot := Stud.Count();
        // Stud.ModifyAll("Basic Science GPA", 0);
        // Stud.ModifyAll("Clinical GPA", 0);
        // Stud.ModifyAll("Overall GPA", 0);
        If Stud.FindFirst() then begin
            Int := 0;
            Ctr += 1;
            IF Bypass then
                WindowDialog.Update(1, Stud."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
            MultipleEnrollmentBool := false;
            CourseMasterRec1.Reset();
            CourseMasterRec1.SetRange(Code, Stud."Course Code");
            IF CourseMasterRec1.FindFirst() then
                IF CourseMasterRec1."Transcript Data Filter" then
                    MultipleEnrollmentBool := true;

            If MultipleEnrollmentBool then begin
                CourseFilter := '';
                CourseMasterRec.Reset();
                CourseMasterRec.SetRange("Transcript Data Filter", true);
                IF CourseMasterRec.FindSet() then begin
                    repeat

                        IF CourseFilter = '' then
                            CourseFilter := CourseMasterRec.Code
                        Else
                            CourseFilter += '|' + CourseMasterRec.Code;
                    until CourseMasterRec.Next() = 0;
                end;
            end;
            if (Stud."Course Code" <> '') and (Stud.Status <> '') then begin
                StudentMaster.Reset();
                If not MultipleEnrollmentBool then begin
                    StudentMaster.SetRange("Enrollment No.", Stud."Enrollment No.");
                    StudentMaster.SetRange("Course Code", Stud."Course Code");
                end;
                If MultipleEnrollmentBool then begin
                    StudentMaster.SetRange("Original Student No.", Stud."Original Student No.");
                    StudentMaster.SetFilter("Course Code", CourseFilter);
                end;
                StudentMaster.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                //StudentMaster.SetRange("Overall GPA", 0);
                If StudentMaster.FindSet() then begin
                    repeat
                        Clear(GradePointsArr);
                        Clear(CreditAttemptArr);
                        Clear(GPA);
                        SemesterTxt := '';
                        TotQualityPoint := 0;
                        TotCreditAttempt := 0;

                        StudSub.Reset();
                        StudSub.SetCurrentKey(Semester);
                        If MultipleEnrollmentBool then begin
                            StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                            StudSub.SetFilter(Course, CourseFilter);
                        end;
                        If not MultipleEnrollmentBool then begin
                            StudSub.SetRange(Course, StudentMaster."Course Code");
                            StudSub.SetRange("Student No.", StudentMaster."No.");
                        end;
                        StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                        Studsub.Setfilter(Semester, '<>%1', '');
                        StudSub.SetFilter("Level Description", '<>%1&<>%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                        StudSub.SetRange(TC, false);
                        if StudSub.FindSet() then
                            repeat
                                Int := Studsub.Sequence;
                                SemesterTxt := Studsub.Semester;
                                IF SemesterTxt = StudSub.Semester then begin
                                    Grade.Reset();
                                    Grade.SetRange(Code, StudSub.Grade);
                                    Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                    if Grade.FindFirst() then begin
                                        If Grade."Consider for GPA" then begin
                                            //CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for non Clinicals
                                            TotCreditAttempt += StudSub."Credits Attempt";
                                        end;
                                        //GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                        TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                    end;

                                    // if ((Grade."Grade Points" * StudSub."Credit Earned") = 0) or (StudSub."Credit Earned" = 0) then
                                    //     Error('Earned Credits %4..%5...Sequence %6.... not matching Student %1..Semester %2..Grade %3', StudSub."Student No.", StudSub.Semester, StudSub.Grade, StudSub."Credit Earned", Grade.Description,
                                    //         StudSub.Sequence);

                                end;
                            until StudSub.Next() = 0;
                        If TotCreditAttempt <> 0 then begin
                            StudentMaster."Basic Science GPA" := Round(TotQualityPoint / TotCreditAttempt);
                            StudentMaster."Overall GPA" := Round(TotQualityPoint / TotCreditAttempt);
                        end;

                        StudSub.Reset();
                        If MultipleEnrollmentBool then begin
                            StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                            StudSub.SetFilter(Course, CourseFilter);
                        end;
                        If not MultipleEnrollmentBool then begin
                            StudSub.SetRange(Course, StudentMaster."Course Code");
                            StudSub.SetRange("Student No.", StudentMaster."No.");
                        end;
                        StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                        StudSub.SetFilter("Level Description", '%1|%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                        StudSub.SetRange(TC, false);
                        if StudSub.FindSet() then
                            repeat
                                Int := 9;
                                Grade.Reset();
                                Grade.SetRange(Code, StudSub.Grade);
                                Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                if Grade.FindFirst() then begin
                                    If Grade."Consider for GPA" then begin
                                        CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for Clinicals
                                        TotCreditAttempt += StudSub."Credits Attempt";
                                    end;
                                    GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                    TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                end;
                            // if ((Grade."Grade Points" * StudSub."Credit Earned") = 0) or (StudSub."Credit Earned" = 0) then
                            //     Error('Earned Credits %4..%5...Sequence %6.... not matching Student %1..Semester %2..Grade %3', StudSub."Student No.", StudSub.Semester, StudSub.Grade, StudSub."Credit Earned", Grade.Description,
                            //         StudSub.Sequence);


                            until StudSub.Next() = 0;
                        // SemesterMaster.Reset();
                        // SemesterMaster.SetRange(Code, StudentMaster.Semester);
                        // IF SemesterMaster.FindFirst() then begin
                        //     if SemesterMaster.Sequence In [1, 2, 3, 4, 5] then
                        //         If TotCreditAttempt <> 0 then begin
                        //             StudentMaster."Basic Science GPA" := Round(TotQualityPoint / TotCreditAttempt);
                        //             StudentMaster."Overall GPA" := Round(TotQualityPoint / TotCreditAttempt);
                        //         end;
                        //     if SemesterMaster.Sequence > 5 then
                        If CreditAttemptArr[9] <> 0 then
                            StudentMaster."Clinical GPA" := Round(GradePointsArr[9] / CreditAttemptArr[9]);

                        If TotCreditAttempt <> 0 then begin
                            StudentMaster."Overall GPA" := Round(TotQualityPoint / TotCreditAttempt);
                        end;
                        // end;

                        StudentMaster.Modify();
                    until StudentMaster.Next() = 0;
                end;

            end;
            IF Bypass then
                WindowDialog.Close();
            //Message('GPA is calculated. Please click on Confirm GPA');
        end
    end;


    procedure OfficialTranscripts1(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript1;
        MedicineOfficialTranscriptNew: Report StandardTranscript1;
        AICASAEMTTranscript: Report AICASAEMTTranscript1;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript1;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript1;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure UnOfficialTranscripts1(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript1;
        MedicineOfficialTranscriptNew: Report StandardTranscript1;
        AICASAEMTTranscript: Report AICASAEMTTranscript1;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript1;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript1;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure OfficialTranscripts2(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript2;
        MedicineOfficialTranscriptNew: Report StandardTranscript2;
        AICASAEMTTranscript: Report AICASAEMTTranscript2;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript2;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript2;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure UnOfficialTranscripts2(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript2;
        MedicineOfficialTranscriptNew: Report StandardTranscript2;
        AICASAEMTTranscript: Report AICASAEMTTranscript2;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript2;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript2;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure OfficialTranscripts3(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript3;
        MedicineOfficialTranscriptNew: Report StandardTranscript3;
        AICASAEMTTranscript: Report AICASAEMTTranscript3;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript3;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript3;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure UnOfficialTranscripts3(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript3;
        MedicineOfficialTranscriptNew: Report StandardTranscript3;
        AICASAEMTTranscript: Report AICASAEMTTranscript3;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript3;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript3;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure OfficialTranscripts4(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript4;
        MedicineOfficialTranscriptNew: Report StandardTranscript4;
        AICASAEMTTranscript: Report AICASAEMTTranscript4;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript4;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript4;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure UnOfficialTranscripts4(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript4;
        MedicineOfficialTranscriptNew: Report StandardTranscript4;
        AICASAEMTTranscript: Report AICASAEMTTranscript4;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript4;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript4;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure OfficialTranscripts5(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript5;
        MedicineOfficialTranscriptNew: Report StandardTranscript5;
        AICASAEMTTranscript: Report AICASAEMTTranscript5;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript5;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript5;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure UnOfficialTranscripts5(Rec: Record "Student Master-CS")
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript5;
        MedicineOfficialTranscriptNew: Report StandardTranscript5;
        AICASAEMTTranscript: Report AICASAEMTTranscript5;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript5;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript5;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

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

    procedure OfficialTranscriptsBulkExport(Rec: Record "Student Master-CS"; PrintDate: Date; DocNo: Code[20]; LineNo: Code[20])
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptLine: Record "Competition L-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript6;
        MedicineOfficialTranscriptNew: Report StandardTranscript6;
        // AICASAEMTTranscript: Report AICASAEMTTranscript6;
        // AUAColOfMedicineVeterinary: Report VeterinaryTranscript6;
        // AUAMedicineMasterScienceReport: Report MSHHSTranscript6;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
        FilePath: Text;
        FileName: Text;
    Begin
        FilePath := '\\10.2.108.135\Bulk Transcript New';

        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        CourseMAsterRec.Setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        // RecMainStudentSubject.SetRange("Grade Confirmed", false);
        // IF RecMainStudentSubject.FindFirst() then
        //     Message('Please Confirm all the Grades!');

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
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No." + ' ' + Format(PrintDate, 0, '<Day> <Month Text> <Year>'), '=', '/') + '.pdf';
                //MedicineOfficialTranscriptNew.SaveAsPdf(FileName);

                TranscriptLine.Reset();
                TranscriptLine.SetRange("Document No.", DocNo);
                TranscriptLine.SetRange("Student Division", LineNo);
                IF TranscriptLine.FindFirst() then begin
                    TranscriptLine.Reprint := true;
                    TranscriptLine."File created" := true;
                    TranscriptLine.Print := True;
                    TranscriptLine.Modify();
                end;
            end;
        end;


        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50118);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
        //         AICASAEMTTranscript.RUNMODAL()
        //     end;
        // end;


        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50123);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
        //         AUAColOfMedicineVeterinary.RUNMODAL();
        //     end;
        // end;



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
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No." + ' ' + Format(PrintDate, 0, '<Day> <Month Text> <Year>'), '=', '/') + '.pdf';
                //StandardTranCreTranscript.SaveAsPdf(FileName);
                TranscriptLine.Reset();
                TranscriptLine.SetRange("Document No.", DocNo);
                TranscriptLine.SetRange("Student Division", LineNo);
                IF TranscriptLine.FindFirst() then begin
                    TranscriptLine.Reprint := true;
                    TranscriptLine."File created" := true;
                    TranscriptLine.Print := True;
                    TranscriptLine.Modify();
                end;
            end;
        end;

        // Clear(AUAMedicineMasterScienceReport);
        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50192);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
        //         AUAMedicineMasterScienceReport.RUNMODAL()
        //     end;
        // end;

    End;

    procedure UnOfficialTranscriptsBulkExport(Rec: Record "Student Master-CS"; PrintDate: Date; DocNo: Code[20]; LineNo: Code[20])
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptLine: Record "Competition L-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript6;
        MedicineOfficialTranscriptNew: Report StandardTranscript6;
        // AICASAEMTTranscript: Report AICASAEMTTranscript6;
        // AUAColOfMedicineVeterinary: Report VeterinaryTranscript6;
        // AUAMedicineMasterScienceReport: Report MSHHSTranscript6;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
        FilePath: Text;
        FileName: Text;
    Begin
        FilePath := '\\10.2.108.135\Bulk Transcript New';

        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then begin
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;
            If CourseMasterRec."EMT Transcript" then
                TransciptDataFilter := true;
        end;

        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // RecMainStudentSubject.Setfilter(Grade, '<>%1', '');
        // RecMainStudentSubject.SetRange("Grade Confirmed", false);
        // IF RecMainStudentSubject.FindFirst() then
        //     Message('Please Confirm all the Grades!');

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
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No." + ' ' + Format(PrintDate, 0, '<Day> <Month Text> <Year>'), '=', '/') + '.pdf';
                //MedicineOfficialTranscriptNew.SaveAsPdf(FileName);
                TranscriptLine.Reset();
                TranscriptLine.SetRange("Document No.", DocNo);
                TranscriptLine.SetRange("Student Division", LineNo);
                IF TranscriptLine.FindFirst() then begin
                    TranscriptLine.Reprint := true;
                    TranscriptLine."File created" := true;
                    TranscriptLine.Print := True;
                    TranscriptLine.Modify();
                end;
            end;
        end;


        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50118);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
        //         AICASAEMTTranscript.RUNMODAL()
        //     end;
        // end;


        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50123);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
        //         AUAColOfMedicineVeterinary.RUNMODAL();
        //     end;
        // end;



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
                FileName := FilePath + '\' + DELCHR(Rec."Student Name" + ' - ' + Rec."No." + ' ' + Format(PrintDate, 0, '<Day> <Month Text> <Year>'), '=', '/') + '.pdf';
                //StandardTranCreTranscript.SaveAsPdf(FileName);
                TranscriptLine.Reset();
                TranscriptLine.SetRange("Document No.", DocNo);
                TranscriptLine.SetRange("Student Division", LineNo);
                IF TranscriptLine.FindFirst() then begin
                    TranscriptLine.Reprint := true;
                    TranscriptLine."File created" := true;
                    TranscriptLine.Print := True;
                    TranscriptLine.Modify();
                end;
            end;
        end;

        // Clear(AUAMedicineMasterScienceReport);
        // RecMainStudentSubject.RESET();
        // RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        // IF not TransciptDataFilter then
        //     RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        // RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        // IF RecMainStudentSubject.Findfirst() then begin
        //     TranscriptTable.Reset();
        //     TranscriptTable.Setrange("Object Id", 50192);
        //     TranscriptTable.SetRange("Course Code", Rec."Course Code");
        //     if TranscriptTable.FindFirst() then begin
        //         AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
        //         AUAMedicineMasterScienceReport.RUNMODAL()
        //     end;
        // end;

    End;
}