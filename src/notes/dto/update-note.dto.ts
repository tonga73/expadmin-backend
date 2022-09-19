import { PartialType } from '@nestjs/mapped-types';
import { CreateNoteDto } from './create-note.dto';

import { IsString, IsOptional, IsNotEmpty } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateNoteDto extends PartialType(CreateNoteDto) {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  name: string;

  @IsString()
  @IsNotEmpty()
  text: string;
}
