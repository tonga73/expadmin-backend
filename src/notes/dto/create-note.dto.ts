import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';

import { Record } from '@prisma/client';

export class CreateNoteDto {
  @IsString()
  @IsNotEmpty()
  @IsOptional()
  name: string;

  @IsInt()
  @IsOptional()
  recordId: number;

  @IsString()
  @IsNotEmpty()
  text: string;
}
