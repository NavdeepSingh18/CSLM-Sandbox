xmlport 50017 "NRMP Match List"
{


    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    Caption = 'NRMP MAtch List Upload';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("NRMP Match List"; "NRMP Match List")
            {
                XmlName = 'NRMP';
                textelement(ECFMGID)
                {
                }
                textelement(SCHOOLNAME)
                {
                }
                textelement(FName)
                {
                }
                textelement(MName)
                {
                }
                textelement(LName)
                {
                }
                textelement(USERTYPECD)
                {
                }
                textelement(MATCHSTATUSCD)
                {
                }
                textelement(PGY1INSTAME)
                {
                }
                textelement(PGY1PGMNAME)
                {
                }
                textelement(PGY1PGMCD)
                {
                }
                textelement(PGY2INSTNAME)
                {
                }
                textelement(PGY2PGMNAME)
                {
                }
                textelement(PGY2PGMCD)
                {
                }
                textelement(MATCHYR)
                {
                }

                textelement(SCHOOLCD)
                {
                }
                trigger OnBeforeInsertRecord()
                begin
                    MATCHSTATUSCD1 := 0;
                    NRMPMatchList.Reset();
                    NRMPMatchList.SetRange(ECFMG_ID, ECFMGID);
                    if not NRMPMatchList.FindFirst() then begin
                        NRMPMatchList.Init();
                        NRMPMatchList.ECFMG_ID := ECFMGID;
                        NRMPMatchList.SCHOOL_NAME := SCHOOLNAME;
                        NRMPMatchList.FNAME := FName;
                        NRMPMatchList.MNAME := MName;
                        NRMPMatchList.LNAME := LName;
                        NRMPMatchList.USER_TYPE_CD := USERTYPECD;
                        if MATCHSTATUSCD = '' then
                            MATCHSTATUSCD1 := 0;
                        if MATCHSTATUSCD = 'REGISTERED' then
                            MATCHSTATUSCD1 := 1;
                        if MATCHSTATUSCD = 'CERTIFIED' then
                            MATCHSTATUSCD1 := 2;
                        if MATCHSTATUSCD = 'INITIAL' then
                            MATCHSTATUSCD1 := 3;
                        if MATCHSTATUSCD = 'WITHDRAWN' then
                            MATCHSTATUSCD1 := 4;

                        NRMPMatchList.MATCH_STATUS_CD := MATCHSTATUSCD1;
                        NRMPMatchList.PGY1_INST_NAME := PGY1INSTAME;
                        NRMPMatchList.PGY1_PGM_NAME := PGY1PGMNAME;
                        NRMPMatchList.PGY1_PGM_CD := PGY1PGMCD;
                        NRMPMatchList.PGY2_INST_NAME := PGY2INSTNAME;
                        NRMPMatchList.PGY2_PGM_NAME := PGY2PGMNAME;
                        NRMPMatchList.PGY2_PGM_CD := PGY2PGMCD;
                        NRMPMatchList.MATCH_YR := MATCHYR;
                        NRMPMatchList.SCHOOL_CD := SCHOOLCD;
                        NRMPMatchList.Insert();
                    end;
                    currXMLport.Skip();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }


    }
    trigger OnPostXmlPort()
    begin
        MESSAGE('Uploaded Successfully !');
    end;

    var
        NRMPMatchList: Record "NRMP Match List";

        MATCHSTATUSCD1: Integer;

}

