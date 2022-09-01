import { IsInt, IsString, IsNotEmpty } from 'class-validator';

export class CreateTracingDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsInt()
  @IsNotEmpty()
  recordId: number;
}
