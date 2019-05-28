function checkExecutableSkill_ElementalStrike(obj)  
{
	if (!obj) return false;
	local isUse = obj.sq_IsUseSkill(SKILL_ELEMENTAL_STRIKE);

	if (isUse) {
		obj.sq_AddSetStatePacket(STATE_ELEMENTAL_STRIKE , STATE_PRIORITY_USER, false);
		return true;
	}

	return false;
}



function checkCommandEnable_ElementalStrike(obj)
{
	if (!obj) return false;
	local state = obj.sq_GetState();
	

	if (state == STATE_STAND)
		return true;

	if(state == STATE_ATTACK)
	{
		return obj.sq_IsCommandEnable(SKILL_ELEMENTAL_STRIKE);
	}	
	
	
	return true;
}


function onSetState_ElementalStrike(obj, state, datas, isResetTimer)
{	
	if(!obj) return;
	obj.sq_StopMove();									
	obj.sq_SetCurrentAnimation(CUSTOM_ANI_ELEMENTAL_STRIKE);
	obj.sq_SetStaticSpeedInfo(SPEED_TYPE_ATTACK_SPEED, SPEED_TYPE_ATTACK_SPEED,
			SPEED_VALUE_DEFAULT, SPEED_VALUE_DEFAULT, 1.0, 1.0);
}

function onEndCurrentAni_ElementalStrike(obj)
{
	obj.sq_AddSetStatePacket(STATE_STAND, STATE_PRIORITY_USER, false);
}


function onKeyFrameFlag_ElementalStrike(obj,flagIndex)
{
	if(!obj)
		return false;

	local isMyControlObject = obj.sq_IsMyControlObject();
    
	if (isMyControlObject && flagIndex == 1)
	{	
		local skillLevel = obj.sq_GetSkillLevel(SKILL_ELEMENTAL_STRIKE); //���ܵ�?
		local createCount = obj.sq_GetLevelData(SKILL_ELEMENTAL_STRIKE, 3, skillLevel);	//���ܵ�?������index=4�����L����

		for(local i = 0; i < createCount; ++i)	//forѭ�h��������L�؏ͳ��F
		{
			
			local attackBonusRate = obj.sq_GetBonusRateWithPassive(SKILL_ELEMENTAL_STRIKE, STATE_ELEMENTAL_STRIKE, SKL_LVL_COLUMN_IDX_0, 1.0);    //��������
			local power = obj.sq_GetPowerWithPassive(SKILL_ELEMENTAL_STRIKE, STATE_ELEMENTAL_STRIKE, SKL_LVL_COLUMN_IDX_1, SKL_LVL_COLUMN_IDX_0, 1.0);	//����
			local upForce = obj.sq_GetLevelData(2);	//���ձ���
					
					
			obj.sq_StartWrite();
			obj.sq_WriteDword(attackBonusRate);
			obj.sq_WriteDword(power);	//������ֵ
			obj.sq_WriteWord(upForce);	//���Վ���
			obj.sq_SendCreatePassiveObjectPacket(24201, 0, 120*(i+1), 1, 0);	//?����Ч����
		}
	}
	return true;
}



