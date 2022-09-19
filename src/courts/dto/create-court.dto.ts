import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';

export class CreateCourtDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  judge: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  address: string;

  @IsInt()
  @IsOptional()
  districtId: number;
}
